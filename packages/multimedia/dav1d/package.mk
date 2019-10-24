# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dav1d"
PKG_VERSION="0.5.0"
PKG_SHA256="b29c159bf7c56e8b6ae81bb24704599819fa89399ec3d6db3dbc052d7bc5baf8"
PKG_LICENSE="BSD"
PKG_SITE="http://www.jbkempf.com/blog/post/2018/Introducing-dav1d"
PKG_URL="https://code.videolan.org/videolan/dav1d/-/archive/${PKG_VERSION}/dav1d-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="dav1d is an AV1 decoder :)"

if [ "${TARGET_ARCH}" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

PKG_MESON_OPTS_TARGET="-Denable_tools=false \
                       -Denable_tests=false"
