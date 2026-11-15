# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="plutovg"
PKG_VERSION="1.3.2"
PKG_SHA256="7bd4e79ce18b1d47517e7e91fbb7cf19d4f01942804a519bc7c0bf32b6325dd5"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/sammycage/plutovg"
PKG_URL="https://github.com/sammycage/plutovg/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="PlutoVG is a standalone 2D vector graphics library in C."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON \
                       -DPLUTOVG_BUILD_EXAMPLES=OFF"
