# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="zstd"
PKG_VERSION="1.4.0"
PKG_SHA256="7f323f0e0c18488748f3d9b2d4353f00e904ea2ccd0372ea04d7f77aa1156557"
PKG_LICENSE="BSD/GPLv2"
PKG_SITE="http://www.zstd.net"
PKG_URL="https://github.com/facebook/zstd/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="gcc:host ninja:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A fast real-time compression algorithm."

configure_package() {
  PKG_CMAKE_SCRIPT="$PKG_BUILD/build/cmake/CMakeLists.txt"
}
