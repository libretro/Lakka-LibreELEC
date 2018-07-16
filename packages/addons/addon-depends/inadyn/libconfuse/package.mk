# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libconfuse"
PKG_VERSION="3.2"
PKG_SHA256="02593cb4fc83854d8d404b77825acfeeff2832e641bd0d9feb4c05a39163279b"
PKG_LICENSE="https://github.com/martinh/libconfuse/blob/master/LICENSE"
PKG_SITE="https://github.com/martinh/libconfuse"
PKG_URL="https://github.com/martinh/libconfuse/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Small configuration file parser library for C"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"
