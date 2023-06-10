# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dav1d"
PKG_VERSION="1.2.0"
PKG_SHA256="231bed8bc1bb28a41d88da6b4c2c118de84b92e5f1d67caffa1b7f81aaea8c6e"
PKG_LICENSE="BSD"
PKG_SITE="https://www.videolan.org/projects/dav1d.html"
PKG_URL="https://downloads.videolan.org/pub/videolan/dav1d/${PKG_VERSION}/dav1d-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="dav1d is an AV1 decoder :)"

if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

PKG_MESON_OPTS_TARGET="-Denable_docs=false \
                       -Denable_examples=false \
                       -Denable_tests=false \
                       -Denable_tools=false \
                       -Dtestdata_tests=false"
