# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libconfuse"
PKG_VERSION="3.2.2"
PKG_SHA256="2cf7e032980aff8f488efba61510dc3fb95e9a4b9183f985dea457a5651b0e2c"
PKG_LICENSE="https://github.com/martinh/libconfuse/blob/master/LICENSE"
PKG_SITE="https://github.com/martinh/libconfuse"
PKG_URL="https://github.com/martinh/libconfuse/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Small configuration file parser library for C"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"
