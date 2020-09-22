# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wavpack"
PKG_VERSION="5.3.0"
PKG_SHA256="b444379a0bee0330f137cb3e9a100e6a12a63a6d01987ba66b3729f85e282307"
PKG_LICENSE="BSD"
PKG_SITE="http://www.wavpack.com"
PKG_URL="http://www.wavpack.com/wavpack-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libiconv"
PKG_LONGDESC="Audio compression format providing lossless, high-quality lossy and hybrid compression mode."

PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTING=OFF \
                       -DWAVPACK_BUILD_PROGRAMS=OFF \
                       -DWAVPACK_BUILD_DOCS=OFF \
                       -DWAVPACK_ENABLE_ASM=OFF \
                       -DWAVPACK_INSTALL_DOCS=OFF"

