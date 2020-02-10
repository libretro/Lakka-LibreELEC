# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="slice-drivers"
PKG_VERSION="8c84fb06f3d66e879bb1d02c5a6d436d31ed6306"
PKG_SHA256="ddc9c97c1ad40cc8fbebf3c501c2bb5cfa2ea22e8fe9af2cb56242c2c72ae202"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/slice-drivers"
PKG_URL="https://github.com/LibreELEC/slice-drivers/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="linux kernel modules for the Slice box"
PKG_IS_KERNEL_PKG="yes"

pre_make_target() {
  unset LDFLAGS
}

make_target() {
  local kdir=$(kernel_path)
  local dtc=${kdir}/scripts/dtc/dtc
  local dtcflags="-@ -O dtb -Wno-unit_address_vs_reg"
  kernel_make KDIR=${kdir}
  ${dtc} ${dtcflags} -o slice.dtbo slice-overlay.dts
  ${dtc} ${dtcflags} -o ws2812.dtbo ws2812-overlay.dts
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/$PKG_NAME
    cp *.ko $INSTALL/$(get_full_module_dir)/$PKG_NAME
  mkdir -p $INSTALL/usr/share/bootloader/overlays
    cp *.dtbo $INSTALL/usr/share/bootloader/overlays
}
