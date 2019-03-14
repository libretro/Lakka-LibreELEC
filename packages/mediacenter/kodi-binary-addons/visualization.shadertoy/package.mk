# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.shadertoy"
PKG_VERSION="1.1.9-Leia"
PKG_SHA256="25b3b1b343350b9eee870d24c7d1ea4634f5499d8548e87fa7589e7119a3ed4d"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/xbmc/visualization.shadertoy"
PKG_URL="https://github.com/xbmc/visualization.shadertoy/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="visualization.shadertoy"
PKG_LONGDESC="visualization.shadertoy"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.player.musicviz"

if [ ! "$OPENGL" = "no" ]; then
# for OpenGL (GLX) support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGL glew"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
# for OpenGL-ES support
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $OPENGLES"
fi

pre_configure_target() {
  if [ "$KODIPLAYER_DRIVER" = bcm2835-driver ]; then
    BCM2835_INCLUDES="-I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads/ \
                      -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
    export CFLAGS="$CFLAGS $BCM2835_INCLUDES"
    export CXXFLAGS="$CXXFLAGS $BCM2835_INCLUDES"
  fi
}
