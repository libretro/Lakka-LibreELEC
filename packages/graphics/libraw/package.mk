# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libraw"
PKG_VERSION="0.19.5"
PKG_SHA256="40a262d7cc71702711a0faec106118ee004f86c86cc228281d12d16da03e02f5"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.libraw.org/"
PKG_URL="http://www.libraw.org/data/LibRaw-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libjpeg-turbo lcms2"
PKG_LONGDESC="A library for reading RAW files obtained from digital photo cameras (CRW/CR2, NEF, RAF, DNG, and others)"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-openmp \
                           --enable-jpeg \
                           --disable-jasper \
                           --enable-lcms \
                           --disable-examples"
