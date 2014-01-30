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

PKG_NAME="libplist"
PKG_VERSION="1.8"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://matt.colyer.name/projects/iphone-linux/"
PKG_URL="http://www.libimobiledevice.org/downloads/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libxml2 glib"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="libplist: a library for manipulating Apple Binary and XML Property Lists"
PKG_LONGDESC="libplist is a library for manipulating Apple Binary and XML Property Lists"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
# dont build parallel
  MAKEFLAGS=-j1
}

configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DENABLE_PYTHON="OFF" \
        -DENABLE_CYTHON="OFF" \
        -DENABLE_SWIG="OFF" \
        ..
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
