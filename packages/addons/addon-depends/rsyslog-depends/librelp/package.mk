# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="librelp"
PKG_VERSION="1.2.17"
PKG_SHA256="1bf88b9decdbcaf06454ea1362455aa5ceccbcce282f07a4dc95e6911da4cbf0"
PKG_LICENSE="GPL"
PKG_SITE="http://www.librelp.com"
PKG_URL="http://download.rsyslog.com/librelp/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Provides reliable event logging over the network."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-tls \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
