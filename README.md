# Docker container for Portfolio Performance

The compiled Docker image can be found on DockerHub: [nimra98/portfolio-performance](https://hub.docker.com/r/nimra98/portfolio-performance)

## Summary

This is a Docker container for [Portfolio Performance](https://www.portfolio-performance.info/en/).

The GUI of the application is accessed through a modern web browser (no installation or configuration needed on the client side) or via any VNC client.

This container is using [jlesage/baseimage-gui](https://hub.docker.com/r/jlesage/baseimage-gui) as baseimage.

It also includes the following software (optional, depending on the Docker image tag used):

- [Nextcloud Client](https://nextcloud.com/): to sync your Portfolio Performance files with a Nextcloud server. The sync is done at container startup and every 30 minutes or when a file is modified.
- [Firefox ESR](https://www.mozilla.org/en-US/firefox/enterprise/): to access the web-pages from the application to look up further information.
- [Tint2](https://gitlab.com/o9000/tint2): a lightweight panel/taskbar for the desktop.
- [XFCE](https://www.xfce.org/): a lightweight desktop environment.

| Image Tag                      | Portfolio Performance | Nextcloud Client | Firefox ESR | Tint2       | XFCE        |
| ------------------------------ | --------------------- | ---------------- | ----------- | ----------- | ----------- |
| pponly-`<version>`             | Specific Version      | -                | -           | -           | -           |
| nextcloud                      | Latest                | Latest*           | -           | -           | -           |
| nextcloud-`<version>`          | Specific Version      | Latest           | -           | -           | -           |
| firefox                        | Latest                | -                | Latest*      | Latest*      | Latest*      |
| firefox-`<version>`            | Specific Version      | -                | Latest*      | Latest*      | Latest*     |
| firefox-nextcloud              | Latest                | Latest*           | Latest*      | Latest*      | Latest*      |
| firefox-nextcloud-`<version>`  | Specific Version      | Latest*           | Latest *     | Latest*      | Latest*      |

`latest*`: The latest version available through apt at the time of the container build. This means that the version of the software can change if the container is rebuilt.

Current refers to the latest version of the software available at the time of the container build. For firefox and Nextcloud PPAs are used to get the latest version (ppa:mozillateam/ppa and ppa:nextcloud-devs/client respectively).

## Mount

### Personal portfolio files

You have to mount /opt/portfolio/workspace to be able to get access and/or upload your Portfolio Performance files.

#### Nextcloud

If you are using Nextcloud, the files from the specified remote path will be synced to /opt/portfolio/workspace/nextcloud.
All files in /opt/portfolio/workspace/nextcloud will be synced to the remote path at container startup and every 15 minutes or when a file is modified.

### Configugration

You have to mount /config to persist you settings.

## Environment Variables

The following public environment variables are provided by the baseimage:

| Variable                | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | Default   |
| ----------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | --------- |
| `USER_ID`               | ID of the user the application runs as.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | `1000`    |
| `GROUP_ID`              | ID of the group the application runs as.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `1000`    |
| `TZ`                    | [TimeZone](http://en.wikipedia.org/wiki/List_of_tz_database_time_zones) used by the container.  Timezone can also be set by mapping `/etc/localtime` between the host and the container.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `Etc/UTC` |
| `DISPLAY_WIDTH`         | Width (in pixels) of the application's window.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | `1920`    |
| `DISPLAY_HEIGHT`        | Height (in pixels) of the application's window.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | `1080`    |
| `WEB_LISTENING_PORT`    | Port used by the web server to serve the UI of the application.  This port is used internally by the container and it is usually not required to be changed.  By default, a container is created with the default bridge network, meaning that, to be accessible, each internal container port must be mapped to an external port (using the `-p` or `--publish` argument).  However, if the container is created with another network type, changing the port used by the container might be useful to prevent conflict with other services/containers.  **NOTE**: a value of `-1` disables listening, meaning that the application's UI won't be accessible over HTTP/HTTPs. | `5800`    |
| `VNC_LISTENING_PORT`    | Port used by the VNC server to serve the UI of the application.  This port is used internally by the container and it is usually not required to be changed.  By default, a container is created with the default bridge network, meaning that, to be accessible, each internal container port must be mapped to an external port (using the `-p` or `--publish` argument).  However, if the container is created with another network type, changing the port used by the container might be useful to prevent conflict with other services/containers.  **NOTE**: a value of `-1` disables listening, meaning that the application's UI won't be accessible over VNC.        | `5900`    |
| `VNC_PASSWORD`          | Password needed to connect to the application's GUI.  See the [VNC Password](#vnc-password) section for more details.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `""`      |
| `NEXTCLOUD_USER`        | OPTIONAL: Username for Nextcloud.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | `""`      |
| `NEXTCLOUD_PASSWORD`    | OPTIONAL: Password for Nextcloud. (If using 2FA, generate an app password in the Nextcloud settings.)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | `""`      |
| `NEXTCLOUD_URL`         | OPTIONAL: URL for Nextcloud. (e.g. <https://cloud.domain.tld>)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | `""`      |
| `NEXTCLOUD_REMOTE_PATH` | OPTIONAL: Remote path for Nextcloud. (e.g. '/Documents')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | `""`      |

## User/Group IDs

When using data volumes (`-v` flags), permissions issues can occur between the
host and the container.  For example, the user within the container may not
exist on the host.  This could prevent the host from properly accessing files
and folders on the shared volume.

To avoid any problem, you can specify the user the application should run as.

This is done by passing the user ID and group ID to the container via the
`USER_ID` and `GROUP_ID` environment variables.

To find the right IDs to use, issue the following command on the host, with the
user owning the data volume on the host:

    id <username>

Which gives an output like this one:

```
uid=1000(myuser) gid=1000(myuser) groups=1000(myuser),4(adm),24(cdrom),27(sudo),46(plugdev),113(lpadmin)
```

The value of `uid` (user ID) and `gid` (group ID) are the ones that you should
be given the container.

## Docker Compose Example

```yaml
version: "3"
services:
  portfolio-performance:
    image: nimra98/portfolio-performance:latest
    container_name: portfolio
    restart: unless-stopped
    #ports: # this is not needed when using traefik
    #  - 5800:5800
    volumes:
      - /opt/docker-volumes/pp/config:/config # Change this to your desired configuration path
      - /opt/docker-volumes/pp/workspace:/opt/portfolio/workspace # Change this to your desired workspace path
    environment:
      USER_ID: 1000
      GROUP_ID: 1000
      DISPLAY_WIDTH: 1920
      DISPLAY_HEIGHT: 1080
      TZ: "Europe/Berlin"
      NEXTCLOUD_USER: "username"
      NEXTCLOUD_PASSWORD: "apppa-sswor-dappp-asswor"
      NEXTCLOUD_REMOTE_PATH: "/Documents"
      NEXTCLOUD_URL: "https://cloud.domain.tld"
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=web-proxy"
      - "traefik.http.routers.portfolio-performance-domain.rule=Host(`portfolio.domain.tld`)"
      - "traefik.http.routers.portfolio-performance-domain.middlewares=sec, sec@file, gzip@file"
      - "traefik.http.routers.portfolio-performance-domain.tls.options=intermediate@file"
      - "traefik.http.routers.portfolio-performance-domain.tls.certresolver=httpchallenge"
      # Declaring the user list
      #
      # Note: when used in docker-compose.yml all dollar signs in the hash need to be doubled for escaping.
      # To create user:password pair, it's possible to use this command:
      # echo $(htpasswd -nB user) | sed -e s/\\$/\\$\\$/g
      #
      # Also note that dollar signs should NOT be doubled when they not evaluated (e.g. Ansible docker_container module).
      - "traefik.http.middlewares.sec.basicauth.users=user:xxxxxxxxxxxxxxxxxxxxxx" # Replace with your own user:password hash
      - "traefik.http.services.portfolio.loadbalancer.server.port=5800" # According to the port used by the container

```
