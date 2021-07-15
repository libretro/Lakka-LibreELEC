# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wavpack"
PKG_VERSION="5.4.0"
PKG_SHA256="4bde6a6b2a86614a6bd2579e60dcc974e2c8f93608d2281110a717c1b3c28b79"
PKG_LICENSE="BSD"
PKG_SITE="http://www.wavpack.com"
PKG_URL="http://www.wavpack.com/wavpack-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libiconv"
PKG_LONGDESC="Audio compression format providing lossless, high-quality lossy and hybrid compression mode."

PKG_CMAKE_OPTS_TARGET="-DBUILD_TESTING=OFF \
                       -DCMAKE_INSTALL_INCLUDEDIR=include/wavpack \
                       -DWAVPACK_BUILD_PROGRAMS=OFF \
                       -DWAVPACK_BUILD_DOCS=OFF \
                       -DWAVPACK_ENABLE_ASM=OFF \
                       -DWAVPACK_INSTALL_DOCS=OFF"
