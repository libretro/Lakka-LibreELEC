# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="efibootmgr"
PKG_VERSION="b9fedd6b6f57055164bc361bc5cf16a602843c6e" # Nov 5, 2021
PKG_SHA256="06061ebf96d28522f5a20b592305e71b91d3fb479ddcce41dadb5180da16d8d8"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/rhboot/efibootmgr"
PKG_URL="https://github.com/rhboot/efibootmgr/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain efivar pciutils zlib"
PKG_LONGDESC="Tool to modify UEFI Firmware Boot Manager Variables."
PKG_BUILD_FLAGS="-sysroot"

make_target() {
  export CFLAGS="${CFLAGS} -I${SYSROOT_PREFIX}/usr/include -I${SYSROOT_PREFIX}/usr/include/efivar -fgnu89-inline -Wno-pointer-sign"
  export LDFLAGS="${LDFLAGS} -L${SYSROOT_PREFIX}/usr/lib -ludev -ldl"

  make EFIDIR=BOOT EFI_LOADER=bootx64.efi PKG_CONFIG=true \
    LDLIBS="-lefiboot -lefivar" \
    efibootmgr
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp -p src/efibootmgr ${INSTALL}/usr/bin
}
