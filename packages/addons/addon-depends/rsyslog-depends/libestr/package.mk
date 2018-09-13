# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libestr"
PKG_VERSION="0.1.10"
PKG_SHA256="e8756b071540314abef25c044f893d6b5d249e46709329a4b3e7361403c29a1e"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://libestr.adiscon.com"
PKG_URL="https://github.com/rsyslog/libestr/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_TOOLCHAIN="autotools"
PKG_LONGDESC="some essentials for string handling (and a bit more)"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
