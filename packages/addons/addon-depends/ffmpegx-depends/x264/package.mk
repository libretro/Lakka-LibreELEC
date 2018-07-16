# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="x264"
PKG_VERSION="snapshot-20180627-2245"
PKG_SHA256="4fa2bcd818fa0ec197c027b3d38ba587ebc4cfb956c2b24deb37e69a46999daf"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.videolan.org/developers/x264.html"
PKG_URL="https://download.videolan.org/x264/snapshots/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="multimedia"
PKG_LONGDESC="x264"

pre_configure_target() {
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
}

configure_target() {
  ./configure \
    --prefix="/usr" \
    --extra-cflags="$CFLAGS" \
    --extra-ldflags="$LDFLAGS" \
    --disable-cli \
    --enable-static \
    --enable-strip \
    --disable-asm \
    --enable-pic \
    --host="$TARGET_NAME" \
    --cross-prefix="$TARGET_PREFIX" \
    --sysroot="$SYSROOT_PREFIX"
}
