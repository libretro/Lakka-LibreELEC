################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="screensaver.shadertoy"
PKG_VERSION="0290c8e"
PKG_SHA256="970eed3e63db75043fafe5a172bcd218bba3b5ae5f3b418206da00865ccb4647"
PKG_REV="2"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/popcornmix/screensaver.shadertoy"
PKG_URL="https://github.com/popcornmix/screensaver.shadertoy/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION=""
PKG_SHORTDESC="screensaver.shadertoy"
PKG_LONGDESC="screensaver.shadertoy"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

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
