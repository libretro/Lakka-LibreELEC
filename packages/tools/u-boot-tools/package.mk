# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="u-boot-tools"
PKG_VERSION="2021.07"
PKG_SHA256="312b7eeae44581d1362c3a3f02c28d806647756c82ba8c72241c7cdbe68ba77e"
PKG_LICENSE="GPL"
PKG_SITE="https://www.denx.de/wiki/U-Boot"
PKG_URL="http://ftp.denx.de/pub/u-boot/u-boot-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_HOST="ccache:host bison:host flex:host"
PKG_LONGDESC="Das U-Boot is a cross-platform bootloader for embedded systems."

make_host() {
  make qemu-x86_64_defconfig
  make tools-only
}

make_target() {
  : # host-only package
}

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
    cp tools/mkimage ${TOOLCHAIN}/bin
}
