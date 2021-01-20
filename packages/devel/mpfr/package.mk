# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpfr"
PKG_VERSION="4.1.0"
PKG_SHA256="0c98a3f1732ff6ca4ea690552079da9c597872d30e96ec28414ee23c95558a7f"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.mpfr.org/"
PKG_URL="http://ftpmirror.gnu.org/mpfr/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_HOST="ccache:host gmp:host"
PKG_LONGDESC="A C library for multiple-precision floating-point computations with exact rounding."

PKG_CONFIGURE_OPTS_HOST="--target=${TARGET_NAME} \
                         --enable-static --disable-shared \
                         --prefix=${TOOLCHAIN} \
                         --with-gmp-lib=${TOOLCHAIN}/lib \
                         --with-gmp-include=${TOOLCHAIN}/include"
