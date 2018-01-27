#
# Lakka Dockerfile
#
# Allows building Lakka through Docker.
#
# Usage:
#
#    docker build -t lakka .
#    docker run -it -v $(pwd):/root lakka
#

FROM ubuntu:xenial

RUN apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y \
		build-essential \
		bash \
		bc \
		build-essential \
		bzip2 \
		diffutils \
		g++ \
		gawk \
		gcc \
		git-core \
		gperf \
		gzip \
		libjson-perl \
		libncurses5-dev \
		lzop \
		make \
		patch \
		patchutils \
		perl \
		sed \
		tar \
		texinfo \
		unzip \
		wget \
		xfonts-utils \
		xfonts-utils \
		xfonts-utils \
		xsltproc \
		xz-utils \
		zip \
	&& rm -rf /var/lib/apt/lists/*

ENV HOME /root
ENV DISTRO Lakka

VOLUME /root

WORKDIR /root

CMD make image