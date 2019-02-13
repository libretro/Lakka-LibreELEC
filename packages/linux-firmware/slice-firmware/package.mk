# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="slice-firmware"
PKG_VERSION="0f463cc"
PKG_SHA256="27e8bac75d5639ca75d683bb2c9b10398c5d7f54f2cf3337ede6abf98e42f751"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/FiveNinjas/slice-firmware"
PKG_URL="https://github.com/libreelec/slice-firmware/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain dtc:host linux"
PKG_LONGDESC="BCM270x firmware related stuff for Slice"
PKG_TOOLCHAIN="manual"

make_target() {
  if [ "$DEVICE" = "Slice3" ]; then
    $(kernel_path)/scripts/dtc/dtc -O dtb -I dts -o dt-blob.bin slice3-dt-blob.dts
  elif [ "$DEVICE" = "Slice" ]; then
    $(kernel_path)/scripts/dtc/dtc -O dtb -I dts -o dt-blob.bin slice-dt-blob.dts
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader/
    cp -a $PKG_BUILD/dt-blob.bin $INSTALL/usr/share/bootloader/
}
