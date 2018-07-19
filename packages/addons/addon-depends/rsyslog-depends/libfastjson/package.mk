# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libfastjson"
PKG_VERSION="0.99.0"
PKG_SHA256="5d19c39daaedfd9b335f6222b521e7529016bc11382cccebe41a9894d4ab32fd"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.rsyslog.com/tag/libfastjson/"
PKG_URL="http://download.rsyslog.com/libfastjson/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="rsyslog"
PKG_SHORTDESC="libfastjson"
PKG_LONGDESC="libfastjson"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
