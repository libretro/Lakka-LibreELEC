# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="valgrind"
PKG_VERSION="3.15.0"
PKG_SHA256="417c7a9da8f60dd05698b3a7bc6002e4ef996f14c13f0ff96679a16873e78ab1"
PKG_LICENSE="GPL"
PKG_SITE="http://valgrind.org/"
PKG_URL="ftp://sourceware.org/pub/valgrind/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A tool to help find memory-management problems in programs"

if [ "$TARGET_ARCH" = "arm" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--enable-only32bit"
elif [ "$TARGET_ARCH" = "aarch64" -o "$TARGET_ARCH" = "x86_64" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--enable-only64bit"
fi
