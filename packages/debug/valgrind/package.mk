# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="valgrind"
PKG_VERSION="3.13.0"
PKG_SHA256="d76680ef03f00cd5e970bbdcd4e57fb1f6df7d2e2c071635ef2be74790190c3b"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://valgrind.org/"
PKG_URL="ftp://sourceware.org/pub/valgrind/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="debug"
PKG_SHORTDESC="A tool to help find memory-management problems in programs"
PKG_LONGDESC="A tool to help find memory-management problems in programs"

if [ "$TARGET_ARCH" = "arm" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--enable-only32bit"
elif [ "$TARGET_ARCH" = "aarch64" -o "$TARGET_ARCH" = "x86_64" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--enable-only64bit"
fi
