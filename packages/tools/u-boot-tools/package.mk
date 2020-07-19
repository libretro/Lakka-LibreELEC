# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="u-boot-tools"
PKG_VERSION="2019.10"
PKG_SHA256="8d6d6070739522dd236cba7055b8736bfe92b4fac0ea18ad809829ca79667014"
PKG_LICENSE="GPL"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_URL="http://ftp.denx.de/pub/u-boot/u-boot-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="ccache:host bison:host flex:host"
PKG_DEPENDS_TARGET="toolchain swig:host"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems."

make_host() {
  make qemu-x86_64_defconfig
  make tools-only
}

make_target() {
  : # host-only package
}

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp tools/mkimage $TOOLCHAIN/bin
}
