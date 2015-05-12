################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="soil"
PKG_VERSION="1.07"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="PD"
PKG_SITE="http://www.lonesock.net/soil.html"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="mesa"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="libsoil: Simple OpenGL Image Library"
PKG_LONGDESC="libsoil: Simple OpenGL Image Library"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  mkdir projects/makefile/obj
  make CXX="$CXX" CC="$CC" LD="$CC" AR="$AR" CFLAGS="-fPIC -O2" CXXFLAGS="-fPIC -O2" -C projects/makefile
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
    cp -PR lib/libSOIL.a $SYSROOT_PREFIX/usr/lib

  mkdir -p $SYSROOT_PREFIX/usr/include/SOIL
    cp -P src/SOIL.h $SYSROOT_PREFIX/usr/include/SOIL
}
