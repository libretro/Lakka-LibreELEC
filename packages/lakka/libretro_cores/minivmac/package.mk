# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="minivmac"
PKG_VERSION="babdf7b53d361a7225858b68a8a64efe8b06f5e5"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-minivmac"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Mini vMac, an early Macintosh (Mac II) emulator"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/lib/libretro"
    cp -v minivmac_libretro.so "${INSTALL}/usr/lib/libretro/"
}
