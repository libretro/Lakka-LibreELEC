from ubuntu:xenial

RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y \
    build-essential make wget bash bc gcc sed patch patchutils tar bzip2 gzip perl gawk gperf zip unzip diffutils texinfo lzop \
    g++ xfonts-utils xfonts-utils xfonts-utils xsltproc libncurses5-dev libjson-perl xz-utils && \
  rm -rf /var/lib/apt/lists/*

ENV HOME /root
ENV DISTRO Lakka

COPY . /root

VOLUME /root

WORKDIR /root

CMD make image