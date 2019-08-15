# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="efibootmgr"
PKG_VERSION="d9eb7f1536ed6262fc8c6518c6afe6053a450e9d"
PKG_SHA256="4c86873c09849b94358859f4cceb27b6c5a3a8576146e282fa22af7a06c137ec"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/rhboot/efibootmgr"
PKG_URL="https://github.com/rhboot/efibootmgr/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain efivar pciutils zlib"
PKG_LONGDESC="Tool to modify UEFI Firmware Boot Manager Variables."

make_target() {
  export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include -I$SYSROOT_PREFIX/usr/include/efivar -fgnu89-inline -Wno-pointer-sign"
  export LDFLAGS="$LDFLAGS -L$SYSROOT_PREFIX/usr/lib -ludev -ldl"

  make EFIDIR=BOOT EFI_LOADER=bootx64.efi PKG_CONFIG=true \
    LDLIBS="-lefiboot -lefivar" \
    efibootmgr
}

makeinstall_target() {
  : # nop
}
