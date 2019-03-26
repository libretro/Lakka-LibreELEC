# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="shairport-sync"
PKG_VERSION="3.2"
PKG_SHA256="18e9343d4bd8ff70674ff3ecdaf7312dd90e716cac2826a4266c95e08ca305bc"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/mikebrady/shairport-sync"
PKG_URL="https://github.com/mikebrady/shairport-sync/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain alsa-lib avahi libconfig libdaemon openssl popt pulseaudio soxr"
PKG_LONGDESC="AirPlay audio player."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--with-alsa \
                           --with-avahi \
                           --with-convolution \
                           --with-metadata \
                           --with-pa \
                           --with-pipe \
                           --with-soxr \
                           --with-ssl=openssl \
                           --with-stdout"

makeinstall_target() {
  :
}
