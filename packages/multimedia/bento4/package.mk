# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bento4"
PKG_VERSION="1.6.0-639"
PKG_SHA256="9f3eb912207d7ed9c1e6e05315083404b32a11f8aacd604a9b2bdcb10bf79eb9"
PKG_LICENSE="GPL"
PKG_SITE="https://www.bento4.com"
PKG_URL="https://github.com/axiomatic-systems/Bento4/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_DEPENDS_UNPACK="inputstream.adaptive"
PKG_LONGDESC="C++ class library and tools designed to read and write ISO-MP4 files"
PKG_BUILD_FLAGS="+pic"

PKG_PATCH_DIRS="$(get_build_dir inputstream.adaptive)/depends/common/bento4"

PKG_CMAKE_OPTS_TARGET="-DBUILD_APPS=OFF"
