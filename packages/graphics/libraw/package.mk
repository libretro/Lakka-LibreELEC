# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libraw"
PKG_VERSION="0.19.2"
PKG_SHA256="400d47969292291d297873a06fb0535ccce70728117463927ddd9452aa849644"
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
                           --disable-examples"
