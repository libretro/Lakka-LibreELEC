# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pngquant"
PKG_VERSION="2.13.1"
PKG_SHA256="4b911a11aa0c35d364b608c917d13002126185c8c314ba4aa706b62fd6a95a7a"
PKG_LICENSE="GPLv3"
PKG_SITE="https://pngquant.org"
PKG_URL="https://pngquant.org/pngquant-${PKG_VERSION}-src.tar.gz"
PKG_DEPENDS_HOST="toolchain:host libpng:host zlib:host"
PKG_LONGDESC="A lossy PNG compressor."

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
