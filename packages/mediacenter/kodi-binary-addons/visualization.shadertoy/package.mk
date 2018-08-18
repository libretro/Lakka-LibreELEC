# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="visualization.shadertoy"
PKG_VERSION="6d70239b0f0062a50640d21aa2b373c03ac29ebd"
PKG_SHA256="6465ed95ed9cc541015226f0c6e99885f743b902478b951e4ff3ce3f660c6b18"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/notspiff/visualization.shadertoy"
PKG_URL="https://github.com/notspiff/visualization.shadertoy/archive/$PKG_VERSION.tar.gz"
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
