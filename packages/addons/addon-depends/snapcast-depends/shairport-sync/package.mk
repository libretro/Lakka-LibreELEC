# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="shairport-sync"
PKG_VERSION="3.3.7"
PKG_SHA256="7f8d4ecec53f2f681a962467bf09205568fc936c8c31a9ee07b1bd72d3d95b12"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/mikebrady/shairport-sync"
PKG_URL="https://github.com/mikebrady/shairport-sync/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib avahi libconfig libdaemon openssl popt pulseaudio soxr"
PKG_LONGDESC="AirPlay audio player."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--with-alsa \
                           --with-avahi \
                           --with-convolution \
                           --with-metadata \
                           --with-pa \
                           --with-pipe \
                           --with-soxr \
                           --with-ssl=openssl \
                           --with-stdout \
                           --without-configfiles"
