# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dav1d"
PKG_VERSION="0.3.0"
PKG_SHA256="22946ddd8c5122d3490b250933328c3278da21b0659db9b7fa8f875e4735c2e6"
PKG_LICENSE="BSD"
PKG_SITE="http://www.jbkempf.com/blog/post/2018/Introducing-dav1d"
PKG_URL="https://code.videolan.org/videolan/dav1d/-/archive/${PKG_VERSION}/dav1d-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="dav1d is an AV1 decoder :)"

if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

PKG_MESON_OPTS_TARGET="-Dbuild_tools=false \
                       -Dbuild_tests=false"
