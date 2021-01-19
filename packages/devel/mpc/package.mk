# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpc"
PKG_VERSION="1.2.1"
PKG_SHA256="17503d2c395dfcf106b622dc142683c1199431d095367c6aacba6eec30340459"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.multiprecision.org"
PKG_URL="http://ftpmirror.gnu.org/mpc/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host gmp:host mpfr:host"
PKG_LONGDESC="A C library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding of the result."

PKG_CONFIGURE_OPTS_HOST="--target=${TARGET_NAME} \
                         --enable-static --disable-shared \
                         --with-gmp=${TOOLCHAIN} \
                         --with-mpfr=${TOOLCHAIN}"
