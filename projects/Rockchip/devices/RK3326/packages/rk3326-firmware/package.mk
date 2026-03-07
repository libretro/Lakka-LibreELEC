# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rk3326-firmware"
PKG_VERSION="490722a"
PKG_LICENSE="Apache"
PKG_SITE="https://github.com/armbian/firmware"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="RK3326 Linux wifi firmware"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware

    # for HARDKERNEL Odroid Go Advance Black Edition wifi firmware
    cp -av eagle_fw*.bin ${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware

    # for ANBERNIC RG351M wifi firmware
    cp -av mt7601u.bin ${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware
}
