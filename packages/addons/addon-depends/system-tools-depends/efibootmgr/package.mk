# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="efibootmgr"
PKG_VERSION="99b578501643377e0b1994b2a068b790d189d5ad"
PKG_SHA256="04bc45dc8a841985d78d8df87b3475eb6e1122f993fae975197bf3adbc6e3341"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/rhboot/efibootmgr"
PKG_URL="https://github.com/rhboot/efibootmgr/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain efivar pciutils zlib"
PKG_LONGDESC="Tool to modify UEFI Firmware Boot Manager Variables."

make_target() {
  export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include -I$SYSROOT_PREFIX/usr/include/efivar -fgnu89-inline"
  export LDFLAGS="$LDFLAGS -L$SYSROOT_PREFIX/usr/lib -ludev -ldl"

  make EFIDIR=BOOT EFI_LOADER=bootx64.efi PKG_CONFIG=true \
    LDLIBS="-lefiboot -lefivar" \
    efibootmgr
}

makeinstall_target() {
  : # nop
}
