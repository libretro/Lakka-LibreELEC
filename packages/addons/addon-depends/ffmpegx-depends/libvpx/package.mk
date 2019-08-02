# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libvpx"
PKG_VERSION="1.8.0"
PKG_SHA256="86df18c694e1c06cc8f83d2d816e9270747a0ce6abe316e93a4f4095689373f6"
PKG_LICENSE="BSD"
PKG_SITE="https://www.webmproject.org"
PKG_URL="https://github.com/webmproject/libvpx/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="WebM VP8/VP9 Codec"

if [ "$TARGET_ARCH" = "x86_64" ]; then
  PKG_DEPENDS_TARGET+=" nasm:host"
fi

configure_target() {

  case $ARCH in
    aarch64)
      PKG_TARGET_NAME_LIBVPX="arm64-linux-gcc"
      ;;
    arm)
      PKG_TARGET_NAME_LIBVPX="armv7-linux-gcc"
      ;;
    x86_64)
      PKG_TARGET_NAME_LIBVPX="x86_64-linux-gcc"
      ;;
  esac

  $PKG_CONFIGURE_SCRIPT --prefix=/usr \
                        --extra-cflags="$CFLAGS" \
                        --as=nasm \
                        --target=$PKG_TARGET_NAME_LIBVPX \
                        --disable-docs \
                        --disable-examples \
                        --disable-shared \
                        --disable-tools \
                        --disable-unit-tests \
                        --disable-vp8-decoder \
                        --disable-vp9-decoder \
                        --enable-ccache \
                        --enable-pic \
                        --enable-static \
                        --enable-vp8 \
                        --enable-vp9
}
