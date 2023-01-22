# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.17 as server-buildstage

# set version label
ARG BUILD_DATE
ARG VERSION
ARG APP_VERSION

RUN \
  apk -U --update --no-cache add --virtual=server-build-dependencies \
    build-base \
    cmake \
    npm \
    python3-dev \
    yarn && \
  echo "*** install your_spotify server ***" && \
  if [ -z ${APP_VERSION+x} ]; then \
    APP_VERSION=$(curl -sX GET "https://api.github.com/repos/Yooooomi/your_spotify/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
  fi && \
  curl -o \
    /tmp/your_spotify.tar.gz -L \
    "https://github.com/Yooooomi/your_spotify/archive/${APP_VERSION}.tar.gz" && \
  mkdir -p /app/www && \
  tar xzf \
    /tmp/your_spotify.tar.gz -C \
    /app/www/ --strip-components=1 && \
  cd /app/www/server && \
  sed -i '/"extends": "..\/tsconfig.json"/d' tsconfig.json  && \  
  yarn --dev --frozen-lockfile && \
  yarn build && \
  yarn cache clean && \
  apk del --purge \
    server-build-dependencies && \
  rm -rf \
    /tmp/*

FROM ghcr.io/linuxserver/baseimage-alpine:3.17 as client-buildstage

ARG NODE_ENV
ENV NODE_ENV ${NODE_ENV:-production}

COPY --from=server-buildstage /app/www/client /app/www/client

RUN \
  apk -U --update --no-cache add --virtual=client-build-dependencies \
    build-base \
    cmake \
    npm \
    python3-dev \
    yarn && \
  echo "*** install your_spotify client ***" && \
  cd /app/www/client && \
  sed -i '/"extends": "..\/tsconfig.json"/d' tsconfig.json  && \  
  npm install -g nodemon && \
  yarn --production=false --frozen-lockfile --network-timeout 60000 && \
  yarn build && \
  yarn cache clean && \
  apk del --purge \
    client-build-dependencies && \
  rm -rf \
    /tmp/*

FROM ghcr.io/linuxserver/baseimage-alpine-nginx:3.17

ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="thespad"

ENV HOME=/app

COPY --from=client-buildstage /app/www/client/build/ /app/www/client/build/
COPY --from=server-buildstage /app/www/server/package.json /app/www/server/package.json
COPY --from=server-buildstage /app/www/server/lib/ /app/www/server/lib/

RUN \
  apk -U --update --no-cache add --virtual=build-dependencies \
    build-base \
    cmake \
    python3-dev && \
  apk add -U --update --no-cache \
    nodejs \
    npm \
    yarn && \
  npm install -g serve && \
  cd /app/www/server && \
  yarn --production && \
  yarn cache clean && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/*

COPY /root /

EXPOSE 3000 8080
