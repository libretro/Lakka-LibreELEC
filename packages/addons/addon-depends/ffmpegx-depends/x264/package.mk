# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="x264"
PKG_VERSION="snapshot-20181001-2245"
PKG_SHA256="edea9b8621da02ebe748101222c974f8a640b19d9d3a3790a24130b892dd7445"
PKG_LICENSE="GPL"
PKG_SITE="http://www.videolan.org/developers/x264.html"
PKG_URL="https://download.videolan.org/x264/snapshots/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="x264 codec"

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
