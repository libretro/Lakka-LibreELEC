# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="minizip"
PKG_VERSION="2.10.4"
PKG_SHA256="6ef3d2e0c15352fe87a4a658b2e8f665fb0c21ddfb57a2e0a515658389d2e850"
PKG_LICENSE="zlib"
PKG_SITE="https://github.com/nmoinvaz/minizip"
PKG_URL="https://github.com/nmoinvaz/minizip/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="zlib"
PKG_LONGDESC="Minizip zlib contribution fork with latest bug fixes"

PKG_CMAKE_OPTS_TARGET="-DUSE_AES=OFF \
                       -DMZ_BUILD_TEST=ON"
