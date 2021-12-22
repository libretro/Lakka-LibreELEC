# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="zstd"
PKG_VERSION="1.5.1"
PKG_SHA256="444f68cf74d2ee6e1d3e53aa99463570bcabf37734f26f86b8aa3fec99446f96"
PKG_LICENSE="BSD/GPLv2"
PKG_SITE="http://www.zstd.net"
PKG_URL="https://github.com/facebook/zstd/releases/download/v${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.zst"
PKG_DEPENDS_HOST="ccache:host meson:host ninja:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A fast real-time compression algorithm."
PKG_TOOLCHAIN="meson"

configure_package() {
  PKG_MESON_SCRIPT="${PKG_BUILD}/build/meson/meson.build"
}

PKG_MESON_OPTS_HOST="-Dlegacy_level=0 \
                     -Dbin_programs=false \
                     -Dzlib=disabled \
                     -Dlzma=disabled \
                     -Dlz4=disabled"
