# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="minizip"
PKG_VERSION="2.9.2"
PKG_SHA256="8425399277d9d5e39454e655cfd3eb004607960c8358a3e732f5e741a6b5df0a"
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
