# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="liblognorm"
PKG_VERSION="2.0.5"
PKG_SHA256="dd779b6992de37995555e1d54caf0716a694765efc65480eed2c713105ab46fe"
PKG_LICENSE="GPL"
PKG_SITE="http://www.liblognorm.com"
PKG_URL="https://github.com/rsyslog/liblognorm/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_TOOLCHAIN="autotools"
PKG_LONGDESC="A fast samples-based log normalization library."

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           ac_cv_func_malloc_0_nonnull=yes \
                           ac_cv_func_realloc_0_nonnull=yes"
