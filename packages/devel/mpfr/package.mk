# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="mpfr"
PKG_VERSION="3.1.5"
PKG_SHA256="015fde82b3979fbe5f83501986d328331ba8ddf008c1ff3da3c238f49ca062bc"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.mpfr.org/"
PKG_URL="http://ftpmirror.gnu.org/mpfr/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="ccache:host gmp:host"
PKG_SECTION="devel"
PKG_SHORTDESC="mpfr: A C library for multiple-precision floating-point computations with exact roundi"
PKG_LONGDESC="The MPFR library is a C library for multiple-precision floating-point computations with exact rounding (also called correct rounding). It is based on the GMP multiple-precision library. The main goal of MPFR is to provide a library for multiple-precision floating-point computation which is both efficient and has well-defined semantics. It copies the good ideas from the ANSI/IEEE-754 standard for double-precision floating-point arithmetic (53-bit mantissa)."

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME \
                         --enable-static --disable-shared \
                         --prefix=$TOOLCHAIN \
                         --with-gmp-lib=$TOOLCHAIN/lib \
                         --with-gmp-include=$TOOLCHAIN/include"
