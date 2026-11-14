# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libwebp"
PKG_VERSION="1.6.0"
PKG_SHA256="e4ab7009bf0629fd11982d4c2aa83964cf244cffba7347ecd39019a9e38c4564"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://developers.google.com/speed/webp"
PKG_URL="https://storage.googleapis.com/downloads.webmproject.org/releases/webp/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libwebp is a library for the WebP image format: lossy and lossless compression."
PKG_TOOLCHAIN="cmake"

# Build just the library + CMake config (WebPConfig.cmake/WebPTargets.cmake),
# not the cwebp/dwebp/gif2webp/img2webp/vwebp/webpinfo command-line tools,
# examples, or extras. WEBP_BUILD_LIBWEBPMUX/WEBP_BUILD_LIBWEBPDEMUX left at
# their defaults (ON) since find_package(WebP) may expect those components.
PKG_CMAKE_OPTS_TARGET="-DBUILD_SHARED_LIBS=ON \
                       -DWEBP_BUILD_ANIM_UTILS=OFF \
                       -DWEBP_BUILD_CWEBP=OFF \
                       -DWEBP_BUILD_DWEBP=OFF \
                       -DWEBP_BUILD_GIF2WEBP=OFF \
                       -DWEBP_BUILD_IMG2WEBP=OFF \
                       -DWEBP_BUILD_VWEBP=OFF \
                       -DWEBP_BUILD_WEBPINFO=OFF \
                       -DWEBP_BUILD_EXTRAS=OFF \
                       -DWEBP_USE_THREAD=ON"
