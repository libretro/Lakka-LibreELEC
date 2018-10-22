# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="libamcodec"
PKG_ARCH="arm aarch64"
PKG_LICENSE="other"
PKG_SITE="http://openlinux.amlogic.com"
case $TARGET_KERNEL_ARCH in
  arm)
    PKG_VERSION="5e23a81"
    PKG_SHA256="412cfafbd9725f5186b884b9599ff6561d2031b44d9873e79d377631a2b5f9b9"
    PKG_URL="https://github.com/codesnake/libamcodec/archive/$PKG_VERSION.tar.gz"
    ;;
  arm64)
    PKG_VERSION="bb19db7"
    PKG_SHA256="81f78b37f2c14313b68cad5c43237dc3a217afaaad4f41e07a840e26673309c4"
    PKG_URL="https://github.com/surkovalex/libamcodec/archive/$PKG_VERSION.tar.gz"
    ;;
esac
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_LONGDESC="libamplayer: Interface library for Amlogic media codecs"

post_unpack() {
  sed -e "s|-lamadec||g" -i $PKG_BUILD/amcodec/Makefile
}

make_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib
  make -C amcodec HEADERS_DIR="$SYSROOT_PREFIX/usr/include/amcodec" PREFIX="$SYSROOT_PREFIX/usr" install
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib
  make -C amcodec HEADERS_DIR="$INSTALL/usr/include/amcodec" PREFIX="$INSTALL/usr" install
}
