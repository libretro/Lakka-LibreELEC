# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="fdupes"
PKG_VERSION="2.0.0"
PKG_SHA256="eb9e3bd3e722ebb2a272e45a1073f78c60f8989b151c3661421b86b14b203410"
PKG_LICENSE="GPL"
PKG_SITE="http://premium.caribe.net/~adrian2/fdupes.html"
PKG_URL="https://github.com/adrianlopezroche/fdupes/releases/download/${PKG_VERSION}/fdupes-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses"
PKG_LONGDESC="A program for identifying or deleting duplicate files residing within specified directories."
PKG_BUILD_FLAGS="-sysroot"

PKG_CONFIGURE_OPTS_TARGET="--without-ncurses"
PKG_MAKE_OPTS_TARGET="PREFIX=/usr"
PKG_MAKEINSTALL_OPTS_TARGET="${PKG_MAKE_OPTS_TARGET}"
