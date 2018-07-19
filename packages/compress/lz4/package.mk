# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lz4"
PKG_VERSION="1.8.0"
PKG_SHA256="2ca482ea7a9bb103603108b5a7510b7592b90158c151ff50a28f1ca8389fccf6"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lz4/lz4"
PKG_URL="https://github.com/lz4/lz4/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="toolchain"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="compress"
PKG_SHORTDESC="lz4 data compressor/decompressor"

PKG_CMAKE_SCRIPT="$PKG_BUILD/contrib/cmake_unofficial/CMakeLists.txt"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=0 -DCMAKE_POSITION_INDEPENDENT_CODE=0"

post_makeinstall_target() {
  rm -rf $INSTALL
}
