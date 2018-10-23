# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="minizip"
PKG_VERSION="1.1"
PKG_SHA256="5666b5ee3e85dfd2dd119970613c12e6267d31813f07d3ffa5d359fe272cb6d1"
PKG_LICENSE="zlib"
PKG_SITE="https://github.com/nmoinvaz/minizip"
PKG_URL="https://github.com/nmoinvaz/minizip/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="zlib"
PKG_LONGDESC="Minizip zlib contribution fork with latest bug fixes"

PKG_CMAKE_OPTS_TARGET="-DUSE_AES=OFF \
                       -DBUILD_TEST=ON"

makeinstall_target() {
  cp -v miniunz_exec $SYSROOT_PREFIX/usr/bin/miniunz
  cp -v minizip_exec $SYSROOT_PREFIX/usr/bin/minizip
}
