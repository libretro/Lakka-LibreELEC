# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libestr"
PKG_VERSION="0.1.10"
PKG_SHA256="bd655e126e750edd18544b88eb1568d200a424a0c23f665eb14bbece07ac703c"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://libestr.adiscon.com/"
PKG_URL="http://libestr.adiscon.com/files/download/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="rsyslog"
PKG_SHORTDESC="libestr: some essentials for string handling (and a bit more)"
PKG_LONGDESC="libestr: some essentials for string handling (and a bit more)"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
