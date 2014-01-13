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

PKG_NAME="gmp"
PKG_VERSION="5.1.3"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://gmplib.org/"
PKG_URL="ftp://ftp.gmplib.org/pub/$PKG_NAME-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_HOST="ccache:host"
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="gmp: The GNU MP (multiple precision arithmetic) library"
PKG_LONGDESC="GNU MP is a library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating point numbers. It has a rich set of functions, and the functions have a regular interface. GNU MP is designed to be as fast as possible, both for small operands and for huge operands. The speed is achieved by using fullwords as the basic arithmetic type, by using fast algorithms, by carefully optimized assembly code for the most common inner loops for a lots of CPUs, and by a general emphasis on speed (instead of simplicity or elegance). The speed of GNU MP is believed to be faster than any other similar library. The advantage for GNU MP increases with the operand sizes for certain operations, since GNU MP in many cases has asymptotically faster algorithms."
PKG_IS_ADDON="no"

PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_HOST="--enable-cxx"
PKG_CONFIGURE_OPTS_TARGET="--disable-cxx"

pre_configure_host() {
  export CFLAGS="$CFLAGS -fPIC -DPIC"
  export CPPFLAGS="$CPPFLAGS -fexceptions"
}

pre_configure_target() {
  export CFLAGS="$CFLAGS -fPIC"
  export CPPFLAGS="$CPPFLAGS -fexceptions"
  export CC_FOR_BUILD="$HOST_CC"
}
