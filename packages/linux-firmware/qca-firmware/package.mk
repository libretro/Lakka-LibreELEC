# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qca-firmware"
PKG_VERSION="09e2d02d9b767ec3aedf89ca11ff2bd9d94a96e0"
PKG_SHA256="d068ef23a5d6401c9d0182575ecb50960da37689fe26394a0e2708cd4b0c0af0"
PKG_LICENSE="QCA"
PKG_URL="https://github.com/LibreELEC/qca-firmware/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="qca-firmware: BT firmware for QCA9377 SDIO modules"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_firmware_dir)
    cp -a ath10k $INSTALL/$(get_full_firmware_dir)
    cp -a qca $INSTALL/$(get_full_firmware_dir)
}
