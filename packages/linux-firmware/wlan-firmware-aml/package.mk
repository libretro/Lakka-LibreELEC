################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="wlan-firmware-aml"
PKG_VERSION="5f5fae7"
PKG_SHA256="a926edbd87b028afcf8048c776859fa2bf0dca006df6a0f6867ce3915bd21494"
PKG_ARCH="any"
PKG_LICENSE="Free-to-use"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/wifi/"
PKG_URL="https://github.com/openwetek/wlan-firmware-aml/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_SHORTDESC="wlan-firmware-aml: Firmware for various WLAN chips used in the devices based on Amlogic SoCs"
PKG_LONGDESC="wlan-firmware-aml: Firmware for various WLAN chips used in the devices based on Amlogic SoCs"
PKG_AUTORECONF="no"

make_target() {
  : # nothing todo
}

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
