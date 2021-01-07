# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libstatgrab"
PKG_VERSION="0.92"
PKG_SHA256="5bf1906aff9ffc3eeacf32567270f4d819055d8386d98b9c8c05519012d5a196"
PKG_SITE="http://www.i-scream.org/libstatgrab/"
PKG_URL="http://ftp.i-scream.org/pub/i-scream/libstatgrab/libstatgrab-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION=libs
PKG_LONGDESC="A library that provides cross platform access to statistics about the system on which it's run."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_malloc_0_nonnull=yes \
                           --enable-static \
                           --disable-shared \
                           --disable-saidar \
                           --disable-examples \
                           --disable-setuid-binaries \
                           --disable-setgid-binaries"
