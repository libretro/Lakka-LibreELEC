# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wlan-firmware-aml"
PKG_VERSION="5f5fae7"
PKG_SHA256="a926edbd87b028afcf8048c776859fa2bf0dca006df6a0f6867ce3915bd21494"
PKG_LICENSE="Free-to-use"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/wifi/"
PKG_URL="https://github.com/openwetek/wlan-firmware-aml/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="wlan-firmware-aml: Firmware for various WLAN chips used in the devices based on Amlogic SoCs"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_firmware_dir)/brcm

  # AP6210
  cp -PR bcm_ampak/config/AP6210/Wi-Fi/fw_bcm40181a2*.bin $INSTALL/$(get_full_firmware_dir)/brcm
  cp -P bcm_ampak/config/AP6210/Wi-Fi/nvram_ap6210.txt $INSTALL/$(get_full_firmware_dir)/brcm
  cp -P bcm_ampak/config/AP6210/BT/bcm20710a1.hcd $INSTALL/$(get_full_firmware_dir)/brcm

  # AP6255
  cp -PR bcm_ampak/config/6255/fw_bcm43455c0_*.bin $INSTALL/$(get_full_firmware_dir)/brcm
  cp -P bcm_ampak/config/6255/nvram.txt $INSTALL/$(get_full_firmware_dir)/brcm/nvram_ap6255.txt
  cp -P bcm_ampak/config/6255/BT/BCM4345C0.hcd $INSTALL/$(get_full_firmware_dir)/brcm/bcm4345c0.hcd

  # AP6330
  cp -PR bcm_ampak/config/AP6330/Wi-Fi/fw_bcm40183b2*.bin $INSTALL/$(get_full_firmware_dir)/brcm
  cp -P bcm_ampak/config/AP6330/Wi-Fi/nvram_ap6330.txt $INSTALL/$(get_full_firmware_dir)/brcm
  cp -P bcm_ampak/config/AP6330/BT/bcm40183b2.hcd $INSTALL/$(get_full_firmware_dir)/brcm

  # AP6335
  cp -PR bcm_ampak/config/6335/fw_bcm4339a0_*.bin $INSTALL/$(get_full_firmware_dir)/brcm
  cp -P bcm_ampak/config/6335/nvram.txt $INSTALL/$(get_full_firmware_dir)/brcm/nvram_ap6335.txt
  cp -P bcm_ampak/config/6335/BT/bcm4335c0.hcd $INSTALL/$(get_full_firmware_dir)/brcm
}
