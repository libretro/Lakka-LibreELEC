# Build container

**Build docker image**

Use the following command to create a docker image and tag it with `libreelec`.

```
docker build --pull -t libreelec tools/docker/focal
```

See https://docs.docker.com/engine/reference/commandline/build/ for details on `docker build` usage.

**Build LibreELEC image inside a container**

Use the following command to build LibreELEC images inside a new container based on the docker image tagged with `libreelec`.

```
docker run --rm -v `pwd`:/build -w /build -it libreelec make image
```

Use `--env`, `-e` or `--env-file` to pass environment variables used by the LibreELEC buildsystem.

```
docker run --rm -v `pwd`:/build -w /build -it -e PROJECT=RPi -e DEVICE=RPi4 -e ARCH=arm libreelec make image
```

See https://docs.docker.com/engine/reference/commandline/run/ for details on `docker run` usage.
