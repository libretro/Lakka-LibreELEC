# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pngquant"
PKG_VERSION="2.12.0"
PKG_SHA256="0e540c64bb58c05f2a05b4eaf1d3d165f0d3278500f15abfeac47f93f8fa8fa8"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://pngquant.org"
PKG_URL="http://pngquant.org/pngquant-${PKG_VERSION}-src.tar.gz"
PKG_DEPENDS_HOST="toolchain libpng:host zlib:host"
PKG_SECTION="graphics"
PKG_SHORTDESC="lossy PNG compressor"
PKG_LONGDESC="a PNG compresor that significantly reduces file sizes by converting images to a more efficient 8-bit PNG format"

configure_host() {
  :
}

make_host() {
  cd $PKG_BUILD
  BIN=$PKG_BUILD/pngquant make

  $STRIP $PKG_BUILD/pngquant
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp $PKG_BUILD/pngquant $TOOLCHAIN/bin
}
