# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="slice-drivers"
PKG_VERSION="cff35bf3819edd3379140ccbbe667cbfd3535e93"
PKG_SHA256="7d159cc52c7ee086468799ec7b2941ba7a39fe5fc372faa59c38a141b8b0ae01"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/slice-drivers"
PKG_URL="https://github.com/LibreELEC/slice-drivers/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
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
