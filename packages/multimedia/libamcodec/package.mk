################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="libamcodec"
PKG_ARCH="arm aarch64"
PKG_LICENSE="other"
PKG_SITE="http://openlinux.amlogic.com"
case $TARGET_ARCH in
  arm)
    PKG_VERSION="5e23a81"
    PKG_URL="https://github.com/codesnake/libamcodec/archive/$PKG_VERSION.tar.gz"
    ;;
  aarch64)
    PKG_VERSION="210755d"
    PKG_URL="http://amlinux.ru/source/$PKG_NAME-$PKG_VERSION.tar.gz"
    ;;
esac
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_SECTION="multimedia"
PKG_SHORTDESC="libamcodec: Interface library for Amlogic media codecs"
PKG_LONGDESC="libamplayer: Interface library for Amlogic media codecs"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make -C amavutils CC="$CC" PREFIX="$SYSROOT_PREFIX/usr"
  mkdir -p $SYSROOT_PREFIX/usr/lib
  cp -PR amavutils/*.so $SYSROOT_PREFIX/usr/lib

  make -C amadec CC="$CC" PREFIX="$SYSROOT_PREFIX/usr" CROSS_PREFIX="$TARGET_PREFIX" install
  make -C amcodec CC="$CC" HEADERS_DIR="$SYSROOT_PREFIX/usr/include/amcodec" PREFIX="$SYSROOT_PREFIX/usr" CROSS_PREFIX="$TARGET_PREFIX" install
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
  cp -PR amavutils/*.so $INSTALL/usr/lib

  make -C amadec PREFIX="$INSTALL/usr" install
  make -C amcodec HEADERS_DIR="$INSTALL/usr/include/amcodec" PREFIX="$INSTALL/usr" install
}
