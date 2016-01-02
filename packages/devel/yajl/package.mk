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

PKG_NAME="yajl"
PKG_VERSION="2.1.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="ISC"
PKG_SITE="http://lloyd.github.com/yajl/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="yajl: Yet Another JSON Library (YAJL) is a small event-driven (SAX-style) JSON parser"
PKG_LONGDESC="Yet Another JSON Library (YAJL) is a small event-driven (SAX-style) JSON parser written in ANSI C, and a small validating JSON generator. YAJL is released under the permissive ISC license."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        ..
}

post_makeinstall_target() {
  mv $SYSROOT_PREFIX/usr/lib/libyajl_s.a $SYSROOT_PREFIX/usr/lib/libyajl.a
  rm $SYSROOT_PREFIX/usr/lib/libyajl.so*

  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/lib
}
