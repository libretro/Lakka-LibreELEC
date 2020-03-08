# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="qca-firmware"
PKG_VERSION="39d025c6d52085c529568c4e110ca6d0b290fef6"
PKG_SHA256="7af9e815f0cc5136819c9f7e02c548ea736d34c9a67ca065e5a693f4fdadb312"
PKG_LICENSE="QCA"
PKG_URL="https://github.com/LibreELEC/qca-firmware/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="qca-firmware: WiFi/BT firmware for QCA9377 SDIO modules"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_firmware_dir)
    cp -a ath10k $INSTALL/$(get_full_firmware_dir)
    cp -a qca $INSTALL/$(get_full_firmware_dir)
}
