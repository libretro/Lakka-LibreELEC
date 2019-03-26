# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libraw"
PKG_VERSION="0.18.7"
PKG_SHA256="87e347c261a8e87935d9a23afd750d27676b99f540e8552314d40db0ea315771"
PKG_LICENSE="LGPL"
PKG_SITE="http://www.libraw.org/"
PKG_URL="http://www.libraw.org/data/LibRaw-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libjpeg-turbo"
PKG_LONGDESC="A library for reading RAW files obtained from digital photo cameras (CRW/CR2, NEF, RAF, DNG, and others)"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-openmp \
                           --enable-jpeg \
                           --disable-jasper \
                           --disable-lcms \
                           --disable-examples \
                           --disable-demosaic-pack-gpl2 \
                           --disable-demosaic-pack-gpl3"
