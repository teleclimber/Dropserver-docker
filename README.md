# Dropserver-docker

This repo contains the files used to generate the docker images found [here](https://hub.docker.com/r/teleclimber/ds-host/tags).

## How To Run:

In `config.sh` set desired version for `ds-host` and `deno`, and set the desired base image.

The following command builds ds-host bin, ds-host, tags everything as latest, and pushes up to Docker hub:

```
./build.sh -abpl
```

## Tips:

- Don't tag as latest `-l` if building an image that is not the latest ds-host version.
- Don't push `-p` if you just want to run images locally.

# Contributions and Expectations:

If you know of ways to improve these Docker images please open an issue. I'm not a Docker person by any means.

Note however that I don't expect Docker to be a way to run `ds-host` in production environments, so I don't expect to put a lot of work here.

See the [docs page on the Docker images](https://dropserver.org/docs/ds-host-docker/) for more details on the limitations of Docker for Dropserver.


