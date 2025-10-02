# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="librelp"
PKG_VERSION="1.12.0"
PKG_SHA256="e2e53a9812d06f95d0a311bbfafba78704835de6d7f0ea0fd9c0d94e8eae496a"
PKG_LICENSE="GPL"
PKG_SITE="https://www.rsyslog.com/category/librelp/"
PKG_URL="https://download.rsyslog.com/librelp/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Provides reliable event logging over the network."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-tls \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
