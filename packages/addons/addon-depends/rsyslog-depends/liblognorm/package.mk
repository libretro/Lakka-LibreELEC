# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="liblognorm"
PKG_VERSION="2.0.1"
PKG_SHA256="6a7fda0da2791a87c808fbfde1af20e6463e3ff73496aae7756e3440f3bc5b75"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.liblognorm.com/"
PKG_URL="http://www.liblognorm.com/files/download/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="rsyslog"
PKG_SHORTDESC="liblognorm"
PKG_LONGDESC="liblognorm"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
