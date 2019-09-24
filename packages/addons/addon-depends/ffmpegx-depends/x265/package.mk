# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="x265"
PKG_VERSION="3.0"
PKG_SHA256="c5b9fc260cabbc4a81561a448f4ce9cad7218272b4011feabc3a6b751b2f0662"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://www.videolan.org/developers/x265.html"
PKG_URL="http://download.videolan.org/pub/videolan/x265/${PKG_NAME}_${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="x265 is a H.265/HEVC video encoder application library"
PKG_TOOLCHAIN="make"

pre_configure_target() {
  LDFLAGS="$LDFLAGS -ldl"
  cmake -G "Unix Makefiles" ./source
}
