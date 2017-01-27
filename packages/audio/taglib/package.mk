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

PKG_NAME="taglib"
PKG_VERSION="1.11.1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://taglib.github.com/"
PKG_URL="http://taglib.github.io/releases/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host zlib"
PKG_SECTION="audio"
PKG_SHORTDESC="taglib: a library for reading and editing the meta-data of several popular audio formats."
PKG_LONGDESC="TagLib is a library for reading and editing the meta-data of several popular audio formats."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=OFF \
                       -DWITH_MP4=ON \
                       -DWITH_ASF=ON"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  # pkgconf hack
  $SED "s:\(['=\" ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/bin/taglib-config
  $SED "s:\([':\" ]\)-I/usr:\\1-I$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib.pc
  $SED "s:\([':\" ]\)-L/usr:\\1-L$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib.pc
  $SED "s:\([':\" ]\)-I/usr:\\1-I$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib_c.pc
  $SED "s:\([':\" ]\)-L/usr:\\1-L$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib_c.pc
}
