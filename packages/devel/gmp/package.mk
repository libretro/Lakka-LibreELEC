# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="gmp"
PKG_VERSION="6.1.2"
PKG_SHA256="87b565e89a9a684fe4ebeeddb8399dce2599f9c9049854ca8c0dfbdea0e21912"
PKG_ARCH="any"
PKG_LICENSE="LGPLv3+"
PKG_SITE="http://gmplib.org/"
PKG_URL="https://gmplib.org/download/gmp/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_SECTION="devel"
PKG_SHORTDESC="gmp: The GNU MP (multiple precision arithmetic) library"
PKG_LONGDESC="GNU MP is a library for arbitrary precision arithmetic, operating on signed integers, rational numbers, and floating point numbers. It has a rich set of functions, and the functions have a regular interface. GNU MP is designed to be as fast as possible, both for small operands and for huge operands. The speed is achieved by using fullwords as the basic arithmetic type, by using fast algorithms, by carefully optimized assembly code for the most common inner loops for a lots of CPUs, and by a general emphasis on speed (instead of simplicity or elegance). The speed of GNU MP is believed to be faster than any other similar library. The advantage for GNU MP increases with the operand sizes for certain operations, since GNU MP in many cases has asymptotically faster algorithms."
PKG_BUILD_FLAGS="+pic:host"

PKG_CONFIGURE_OPTS_HOST="--enable-cxx --enable-static --disable-shared"

pre_configure_host() {
  export CPPFLAGS="$CPPFLAGS -fexceptions"
}
