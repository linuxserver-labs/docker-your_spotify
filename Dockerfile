FROM ghcr.io/linuxserver/baseimage-alpine:3.15 as server-buildstage

# set version label
ARG YOUR_SPOTIFY_RELEASE
LABEL build_version="Linuxserver.io version:- ${YOUR_SPOTIFY_RELEASE}"
LABEL maintainer="thespad"

RUN \
  apk -U --update --no-cache add --virtual=server-build-dependencies \
    build-base \
    cmake \
    curl \
    gcc \
    g++ \
    jq \
    make \
    npm \
    python3-dev \
    yarn && \
  echo "*** install your_spotify server ***" && \
  if [ -z ${YOUR_SPOTIFY_RELEASE+x} ]; then \
    YOUR_SPOTIFY_RELEASE=$(curl -sX GET "https://api.github.com/repos/Yooooomi/your_spotify/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  curl -o \
    /tmp/your_spotify.tar.gz -L \
    "https://github.com/Yooooomi/your_spotify/archive/${YOUR_SPOTIFY_RELEASE}.tar.gz" && \
  mkdir -p /app/your_spotify && \
  tar xzf \
    /tmp/your_spotify.tar.gz -C \
    /app/your_spotify/ --strip-components=1 && \
  cd /app/your_spotify/server && \
  sed -i '/"extends": "..\/tsconfig.json"/d' tsconfig.json  && \  
  yarn --dev --frozen-lockfile && \
  yarn build && \
  yarn cache clean && \
  apk del --purge \
    server-build-dependencies && \
  rm -rf \
    /tmp/*

FROM ghcr.io/linuxserver/baseimage-alpine:3.15 as client-buildstage

ARG NODE_ENV
ENV NODE_ENV ${NODE_ENV:-production}

COPY --from=server-buildstage /app/your_spotify/client /app/your_spotify/client

RUN \
  apk -U --update --no-cache add --virtual=client-build-dependencies \
    build-base \
    cmake \
    gcc \
    g++ \
    make \
    npm \
    python3-dev \
    yarn && \
  echo "*** install your_spotify client ***" && \
  cd /app/your_spotify/client && \
  sed -i '/"extends": "..\/tsconfig.json"/d' tsconfig.json  && \  
  npm install -g nodemon && \
  yarn --production=false --frozen-lockfile --network-timeout 60000 && \
  yarn build && \
  yarn cache clean && \
  apk del --purge \
    client-build-dependencies && \
  rm -rf \
    /tmp/*

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.15

ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thespad"

ENV HOME=/app

COPY --from=client-buildstage /app/your_spotify/client/build/ /app/your_spotify/client/build/
COPY --from=server-buildstage /app/your_spotify/server/package.json /app/your_spotify/server/package.json
COPY --from=server-buildstage /app/your_spotify/server/lib/ /app/your_spotify/server/lib/

RUN \
  apk -U --update --no-cache add --virtual=build-dependencies \
    build-base \
    cmake \
    gcc \
    g++ \
    python3-dev && \
  apk add -U --update --no-cache \
    curl \
    nodejs \
    npm \
    yarn && \
  npm install -g serve && \
  cd /app/your_spotify/server && \
  yarn --production && \
  yarn cache clean && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/*

COPY /root /

EXPOSE 3000 8080
