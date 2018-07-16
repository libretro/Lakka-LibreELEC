# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="librelp"
PKG_VERSION="1.2.12"
PKG_SHA256="0355730524f7b20bed1b85697296b6ce57ac593ddc8dddcdca263da71dee7bd7"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.librelp.com/"
PKG_URL="http://download.rsyslog.com/librelp/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="rsyslog"
PKG_SHORTDESC="librelp"
PKG_LONGDESC="librelp"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-tls \
                           --enable-static --disable-shared \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
