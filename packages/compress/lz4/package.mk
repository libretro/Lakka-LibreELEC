# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="lz4"
PKG_VERSION="1.9.2"
PKG_SHA256="658ba6191fa44c92280d4aa2c271b0f4fbc0e34d249578dd05e50e76d0e5efcc"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lz4/lz4"
PKG_URL="https://github.com/lz4/lz4/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="lz4 data compressor/decompressor"

configure_package() {
  PKG_CMAKE_SCRIPT="$PKG_BUILD/contrib/cmake_unofficial/CMakeLists.txt"

  PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=0 -DCMAKE_POSITION_INDEPENDENT_CODE=0"
}

post_makeinstall_target() {
  rm -rf $INSTALL
}
