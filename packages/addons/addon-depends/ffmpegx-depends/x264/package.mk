# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="x264"
PKG_VERSION="545de2ffec6ae9a80738de1b2c8cf820249a2530"
PKG_SHA256="74725cf7036b2c96387c2c014ef00d181942d00230f21e16277f11d2d9683adc"
PKG_LICENSE="GPL"
PKG_SITE="http://www.videolan.org/developers/x264.html"
PKG_URL="http://repo.or.cz/x264.git/snapshot/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="x264 codec"

if [ "$TARGET_ARCH" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

pre_configure_target() {
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME

  if [ "$TARGET_ARCH" = "x86_64" ]; then
    export AS="$TOOLCHAIN/bin/nasm"
    PKG_X264_ASM="--enable-asm"
  else
    PKG_X264_ASM="--disable-asm"
  fi
}

configure_target() {
  ./configure \
    --cross-prefix="$TARGET_PREFIX" \
    --extra-cflags="$CFLAGS" \
    --extra-ldflags="$LDFLAGS" \
    --host="$TARGET_NAME" \
    --prefix="/usr" \
    --sysroot="$SYSROOT_PREFIX" \
    $PKG_X264_ASM \
    --disable-cli \
    --enable-lto \
    --enable-pic \
    --enable-static \
    --enable-strip
}
