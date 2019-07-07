# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="aom"
PKG_VERSION="add63ad6740a9882d2760abc68a03cd7ee836c7e"
PKG_SHA256="f45996e2ed4d689c5ea84d449cd702981690afecd4bc641e09e96f8883bddd2d"
PKG_LICENSE="BSD"
PKG_SITE="https://www.webmproject.org"
PKG_URL="http://repo.or.cz/aom.git/snapshot/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="AV1 Codec Library"

PKG_CMAKE_OPTS_TARGET="-DENABLE_CCACHE=1 \
                       -DENABLE_DOCS=0 \
                       -DENABLE_EXAMPLES=0 \
                       -DENABLE_TESTS=0 \
                       -DENABLE_TOOLS=0"

if [ "$TARGET_ARCH" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

if ! target_has_feature neon; then
  PKG_CMAKE_OPTS_TARGET+=" -DENABLE_NEON=0 -DENABLE_NEON_ASM=0"
fi
