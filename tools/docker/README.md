# Build container

**Docker containers**
- Ubuntu
  - bionic  (Ubuntu 18.04)
  - focal   (Ubuntu 20.04)
  - groovy  (Ubuntu 20.10)
  - hirsute (Ubuntu 21.04)
- Debian
  - stretch (Debian  9.0)
  - buster  (Debian 10.0)
  - sid     (Debian unstable)

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
