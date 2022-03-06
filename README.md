<!-- DO NOT EDIT THIS FILE MANUALLY  -->
<!-- Please read the https://github.com/linuxserver/docker-your_spotify/blob/main/.github/CONTRIBUTING.md -->

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/lsio-labs-wide.png)](https://linuxserver.io)

[![Blog](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=Blog)](https://blog.linuxserver.io "all the things you can do with our containers including How-To guides, opinions and much more!")
[![Discord](https://img.shields.io/discord/354974912613449730.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=Discord&logo=discord)](https://discord.gg/YWrKVTn "realtime support / chat with the community and the team.")
[![Discourse](https://img.shields.io/discourse/https/discourse.linuxserver.io/topics.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=discourse)](https://discourse.linuxserver.io "post on our community forum.")
[![Fleet](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=Fleet)](https://fleet.linuxserver.io "an online web interface which displays all of our maintained images.")
[![GitHub](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=GitHub&logo=github)](https://github.com/linuxserver "view the source for all of our repositories.")
[![Open Collective](https://img.shields.io/opencollective/all/linuxserver.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=Supporters&logo=open%20collective)](https://opencollective.com/linuxserver "please consider helping us by either donating or contributing to our budget")

> ## **_WARNING:_**  Linuxserver Labs images are *not* production ready and we do not provide support for them. They are experimental and could change/break at any time. Please do not deploy them anywhere important

The [LinuxServer.io](https://linuxserver.io) team brings you another container release featuring:

* regular and timely application updates
* easy user mappings (PGID, PUID)
* custom base image with s6 overlay
* weekly base OS updates with common layers across the entire LinuxServer.io ecosystem to minimise space usage, down time and bandwidth
* regular security updates

Find us at:

* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [Discourse](https://discourse.linuxserver.io) - post on our community forum.
* [Fleet](https://fleet.linuxserver.io) - an online web interface which displays all of our maintained images.
* [GitHub](https://github.com/linuxserver) - view the source for all of our repositories.
* [Open Collective](https://opencollective.com/linuxserver) - please consider helping us by either donating or contributing to our budget

# [linuxserver-labs/your_spotify](https://github.com/linuxserver-labs/docker-your_spotify)

[![Scarf.io pulls](https://scarf.sh/installs-badge/linuxserver-ci/linuxserver-labs%2Fyour_spotify?color=94398d&label-color=555555&logo-color=ffffff&style=for-the-badge&package-type=docker)](https://scarf.sh/gateway/linuxserver-ci/docker/linuxserver-labs%2Fyour_spotify)
[![GitHub Stars](https://img.shields.io/github/stars/linuxserver-labs/docker-your_spotify.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/linuxserver-labs/docker-your_spotify)
[![GitHub Release](https://img.shields.io/github/release/linuxserver-labs/docker-your_spotify.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/linuxserver-labs/docker-your_spotify/releases)
[![GitHub Package Repository](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=GitHub%20Package&logo=github)](https://github.com/linuxserver-labs/docker-your_spotify/packages)

[your_spotify](https://github.com/Yooooomi/your_spotify) is a self-hosted application that tracks what you listen and offers you a dashboard to explore statistics about it! It's composed of a web server which polls the Spotify API every now and then and a web application on which you can explore your statistics.

[![your_spotify](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/your_spotify-banner.png)](https://github.com/Yooooomi/your_spotify)

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/).

Simply pulling `lscr.io/linuxserver-labs/your_spotify:latest` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | latest |
| arm64 | ✅ | latest |
| armhf | ❌ |  |

## Application Setup

You have to create a Spotify application through their [developer dashboard](https://developer.spotify.com/dashboard/applications) to get your Client ID and secret. Set the Redirect URI to match your APP_URL address with `/api/oauth/spotify/callback` included after the domain (i.e., `http://localhost/api/oauth/spotify/callback).

The application requires an external mongodb database, supported versions are 4.x and 5.x.

This ia an all-in-one container which includes both the server and client components. If you require these to be separate then please use the releases from the [your_spotify repo](https://github.com/Yooooomi/your_spotify).

### Import History

By default, Your Spotify will only retrieve data for the past 24 hours once registered. This is a technical limitation. However, you can:

* Request your privacy data at Spotify to have access to your history for the past year [here](https://www.spotify.com/us/account/privacy/). This *can* take up to 30 days.
* Optional: once received, you can ask for extended data that will get you your whole history. You have to email privacy@spotify.com saying you want all your data since account creation.
* Go to the settings of your account and import your StreamingHistoryX.json files.
* Now you can follow the progress of the import with the progress bar.

For more information see [your_spotify](https://github.com/Yooooomi/your_spotify).

## Usage

Here are some example snippets to help you get started creating a container.

### docker-compose (recommended, [click here for more info](https://docs.linuxserver.io/general/docker-compose))

```yaml
---
version: "2.1"
services:
  your_spotify:
    image: lscr.io/linuxserver-labs/your_spotify:latest
    container_name: your_spotify
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - APP_URL=http://localhost
      - SPOTIFY_PUBLIC=ABC123
      - SPOTIFY_SECRET=XYZ098
      - CORS=http://localhost:80,https://localhost:443
      - MONGO_ENDPOINT=mongodb://mongo:27017/your_spotify
    ports:
      - 80:80
      - 443:443
    restart: unless-stopped
```

### docker cli ([click here for more info](https://docs.docker.com/engine/reference/commandline/cli/))

```bash
docker run -d \
  --name=your_spotify \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europe/London \
  -e APP_URL=http://localhost \
  -e SPOTIFY_PUBLIC=ABC123 \
  -e SPOTIFY_SECRET=XYZ098 \
  -e CORS=http://localhost:80,https://localhost:443 \
  -e MONGO_ENDPOINT=mongodb://mongo:27017/your_spotify \
  -p 80:80 \
  -p 443:443 \
  --restart unless-stopped \
  lscr.io/linuxserver-labs/your_spotify:latest
```

## Parameters

Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-p 80` | HTTP port. |
| `-p 443` | HTTPS port. |
| `-e PUID=1000` | for UserID - see below for explanation |
| `-e PGID=1000` | for GroupID - see below for explanation |
| `-e TZ=Europe/London` | Specify a timezone to use EG Europe/London. |
| `-e APP_URL=http://localhost` | The protocol and hostname where the app will be accessed. |
| `-e SPOTIFY_PUBLIC=ABC123` | Your Spotify application client ID. |
| `-e SPOTIFY_SECRET=XYZ098` | Your Spotify application secret. |
| `-e CORS=http://localhost:80,https://localhost:443` | Allowed CORS sources, set to `all` to allow any source. |
| `-e MONGO_ENDPOINT=mongodb://mongo:27017/your_spotify` | Set mongodb endpoint address/port. |

## Environment variables from files (Docker secrets)

You can set any environment variable from a file by using a special prepend `FILE__`.

As an example:

```bash
-e FILE__PASSWORD=/run/secrets/mysecretpassword
```

Will set the environment variable `PASSWORD` based on the contents of the `/run/secrets/mysecretpassword` file.

## Umask for running applications

For all of our images we provide the ability to override the default umask settings for services started within the containers using the optional `-e UMASK=022` setting.
Keep in mind umask is not chmod it subtracts from permissions based on it's value it does not add. Please read up [here](https://en.wikipedia.org/wiki/Umask) before asking for support.

## User / Group Identifiers

When using volumes (`-v` flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```bash
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Docker Mods

[![Docker Mods](https://img.shields.io/badge/dynamic/yaml?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=your_spotify&query=%24.mods%5B%27your_spotify%27%5D.mod_count&url=https%3A%2F%2Fraw.githubusercontent.com%2Flinuxserver%2Fdocker-mods%2Fmaster%2Fmod-list.yml)](https://mods.linuxserver.io/?mod=your_spotify "view available mods for this container.") [![Docker Universal Mods](https://img.shields.io/badge/dynamic/yaml?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=universal&query=%24.mods%5B%27universal%27%5D.mod_count&url=https%3A%2F%2Fraw.githubusercontent.com%2Flinuxserver%2Fdocker-mods%2Fmaster%2Fmod-list.yml)](https://mods.linuxserver.io/?mod=universal "view available universal mods.")

We publish various [Docker Mods](https://github.com/linuxserver/docker-mods) to enable additional functionality within the containers. The list of Mods available for this image (if any) as well as universal mods that can be applied to any one of our images can be accessed via the dynamic badges above.

## Support Info

* Shell access whilst the container is running: `docker exec -it your_spotify /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f your_spotify`
* container version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' your_spotify`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' lscr.io/linuxserver/your_spotify`

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (ie. nextcloud, plex), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.

Below are the instructions for updating containers:

### Via Docker Compose

* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull your_spotify`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d your_spotify`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Run

* Update the image: `docker pull lscr.io/linuxserver/your_spotify`
* Stop the running container: `docker stop your_spotify`
* Delete the container: `docker rm your_spotify`
* Recreate a new container with the same docker run parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* You can also remove the old dangling images: `docker image prune`

### Via Watchtower auto-updater (only use if you don't remember the original parameters)

* Pull the latest image at its tag and replace it with the same env variables in one run:

  ```bash
  docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower \
  --run-once your_spotify
  ```

* You can also remove the old dangling images: `docker image prune`

**Note:** We do not endorse the use of Watchtower as a solution to automated updates of existing Docker containers. In fact we generally discourage automated updates. However, this is a useful tool for one-time manual updates of containers where you have forgotten the original parameters. In the long term, we highly recommend using [Docker Compose](https://docs.linuxserver.io/general/docker-compose).

### Image Update Notifications - Diun (Docker Image Update Notifier)

* We recommend [Diun](https://crazymax.dev/diun/) for update notifications. Other tools that automatically update containers unattended are not recommended or supported.

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:

```bash
git clone https://github.com/linuxserver-labs/docker-your_spotify.git
cd docker-your_spotify
docker build \
  --no-cache \
  --pull \
  -t lscr.io/linuxserver-labs/your_spotify:latest .
```

The ARM variants can be built on x86_64 hardware using `multiarch/qemu-user-static`

```bash
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **23.02.22:** - Initial Release.
