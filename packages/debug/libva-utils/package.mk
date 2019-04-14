# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libva-utils"
PKG_VERSION="2.4.1"
PKG_SHA256="4ab6faa6592ffe2d4817450f5453f3974b47441650e8f49e1a12497ce2a794ac"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/01org/libva-utils"
PKG_URL="https://github.com/intel/libva-utils/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="Libva-utils is a collection of tests for VA-API (VIdeo Acceleration API)"
PKG_TOOLCHAIN="autotools"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="toolchain libva libdrm libX11"
  DISPLAYSERVER_LIBVA="--enable-x11"
else
  PKG_DEPENDS_TARGET="toolchain libva libdrm"
  DISPLAYSERVER_LIBVA="--disable-x11"
fi

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --enable-drm \
                           $DISPLAYSERVER_LIBVA \
                           --disable-wayland \
                           --disable-tests"
