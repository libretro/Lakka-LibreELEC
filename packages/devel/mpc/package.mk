# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="mpc"
PKG_VERSION="1.0.3"
PKG_SHA256="617decc6ea09889fb08ede330917a00b16809b8db88c29c31bfbb49cbf88ecc3"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.multiprecision.org"
PKG_URL="http://ftpmirror.gnu.org/mpc/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host gmp:host mpfr:host"
PKG_SECTION="devel"
PKG_SHORTDESC="mpc: A C library for the arithmetic of high precision complex numbers"
PKG_LONGDESC="pc is a C library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding of the result. It is built upon and follows the same principles as Mpfr."

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME \
                         --enable-static --disable-shared \
                         --with-gmp=$TOOLCHAIN \
                         --with-mpfr=$TOOLCHAIN"
