# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="efibootmgr"
PKG_VERSION="edc8b9b6ec1c7751ccb9a483405c99141ba237fc"
PKG_SHA256="e951ce9e0534c63bb71ba8b2a3830d4402e51440cb4d524d18c1ef40ae5ee218"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/rhboot/efibootmgr"
PKG_URL="https://github.com/rhboot/efibootmgr/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain efivar pciutils zlib"
PKG_LONGDESC="Tool to modify UEFI Firmware Boot Manager Variables."
PKG_BUILD_FLAGS="-sysroot"

make_target() {
  export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include -I$SYSROOT_PREFIX/usr/include/efivar -fgnu89-inline -Wno-pointer-sign"
  export LDFLAGS="$LDFLAGS -L$SYSROOT_PREFIX/usr/lib -ludev -ldl"

  make EFIDIR=BOOT EFI_LOADER=bootx64.efi PKG_CONFIG=true \
    LDLIBS="-lefiboot -lefivar" \
    efibootmgr
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp -p src/efibootmgr $INSTALL/usr/bin
}
