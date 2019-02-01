# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mpc"
PKG_VERSION="1.1.0"
PKG_SHA256="6985c538143c1208dcb1ac42cedad6ff52e267b47e5f970183a3e75125b43c2e"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.multiprecision.org"
PKG_URL="http://ftpmirror.gnu.org/mpc/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host gmp:host mpfr:host"
PKG_LONGDESC="A C library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding of the result."

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME \
                         --enable-static --disable-shared \
                         --with-gmp=$TOOLCHAIN \
                         --with-mpfr=$TOOLCHAIN"
