# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="realtek-wifi-firmware"
PKG_VERSION="490722a"
PKG_LICENSE="Apache"
PKG_SITE="https://github.com/armbian/firmware"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="Realtek Linux wifi firmware"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  # for RTL8188EU
  mkdir -p "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/rtlwifi"
    cp -av rtlwifi/rtl8188eufw.bin "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/rtlwifi"

  # for RTW88 series
  mkdir -p "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/rtw88"
    cp -av rtw88/* "${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/rtw88"
}
