# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="plutosvg"
PKG_VERSION="0.0.8"
PKG_SHA256="49d5cfe772d3aa10cd4879f2f6e189f5083c08e4c8ea01bf3d5b87c97dfca7d2"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/sammycage/plutosvg"
PKG_URL="https://github.com/sammycage/plutosvg/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain plutovg freetype"
PKG_LONGDESC="PlutoSVG is a compact and efficient SVG rendering library in C, built on PlutoVG."
PKG_TOOLCHAIN="cmake"

# Matches the flags PCSX2 upstream itself builds this dependency with.
PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON \
                       -DPLUTOSVG_ENABLE_FREETYPE=ON \
                       -DPLUTOSVG_BUILD_EXAMPLES=OFF"
