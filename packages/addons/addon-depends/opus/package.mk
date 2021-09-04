# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="opus"
PKG_VERSION="1.3.1"
PKG_SHA256="65b58e1e25b2a114157014736a3d9dfeaad8d41be1c8179866f144a2fb44ff9d"
PKG_LICENSE="BSD"
PKG_SITE="http://www.opus-codec.org"
PKG_URL="https://archive.mozilla.org/pub/opus/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Codec designed for interactive speech and audio transmission over the Internet."
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS="+pic"

if [ "${TARGET_ARCH}" = "arm" ]; then
  PKG_FIXED_POINT="--enable-fixed-point"
else
  PKG_FIXED_POINT="--disable-fixed-point"
fi

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           ${PKG_FIXED_POINT}"
