# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libstatgrab"
PKG_VERSION="0.91"
PKG_SHA256="03e9328e4857c2c9dcc1b0347724ae4cd741a72ee11acc991784e8ef45b7f1ab"
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
