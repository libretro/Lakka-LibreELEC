# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="efibootmgr"
PKG_VERSION="438ba96669012c7e7226f8c574a482f12147f098"
PKG_SHA256="3ac3147f41b2a65ecd2b4abf73012c7fdafa77b4bb5a3913022dac0fdfc15d52"
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
