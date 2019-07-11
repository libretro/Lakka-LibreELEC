# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libva"
PKG_VERSION="2.5.0"
PKG_SHA256="9b6264dade6b6d3edb59c6c4f3c9217d1d5a195635fc07da875d565f58624418"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://01.org/linuxmedia"
PKG_URL="https://github.com/intel/libva/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="Libva is an implementation for VA-API (VIdeo Acceleration API)."
PKG_TOOLCHAIN="autotools"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="toolchain libX11 libXext libXfixes libdrm"
  DISPLAYSERVER_LIBVA="--enable-x11 --disable-glx --disable-wayland"
elif [ "$DISPLAYSERVER" = "weston" ]; then
  DISPLAYSERVER_LIBVA="--disable-x11 --disable-glx --enable-wayland"
  PKG_DEPENDS_TARGET="toolchain libdrm wayland"
else
  PKG_DEPENDS_TARGET="toolchain libdrm"
  DISPLAYSERVER_LIBVA="--disable-x11 --disable-glx --disable-wayland"
fi

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --disable-docs \
                           --enable-drm \
                           $DISPLAYSERVER_LIBVA"
