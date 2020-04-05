# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libudfread"
PKG_VERSION="1.0.0"
PKG_SHA256="539dd69d2f43816a2a3f69b77fae05268c3930650c2d0d5b092614cce853583c"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="https://code.videolan.org/videolan/libudfread"
PKG_URL="https://code.videolan.org/videolan/$PKG_NAME/-/archive/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="UDF reader"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"
