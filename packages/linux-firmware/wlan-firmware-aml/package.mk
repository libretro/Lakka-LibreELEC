################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2016 Team LibreELEC
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
PKG_VERSION="b74369c"
PKG_ARCH="any"
PKG_LICENSE="Free-to-use"
PKG_SITE="http://openlinux.amlogic.com:8000/download/ARM/wifi/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_SHORTDESC="wlan-firmware-aml: Firmware for various WLAN chips used in the devices based on Amlogic SoCs"
PKG_LONGDESC="wlan-firmware-aml: Firmware for various WLAN chips used in the devices based on Amlogic SoCs"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing todo
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/firmware/brcm

  cp -PR bcm_ampak/config/AP6330/Wi-Fi/fw_bcm40183b2*.bin $INSTALL/usr/lib/firmware/brcm
  cp -P bcm_ampak/config/AP6330/Wi-Fi/nvram_ap6330.txt $INSTALL/usr/lib/firmware/brcm
  cp -P bcm_ampak/config/AP6330/BT/bcm40183b2.hcd $INSTALL/usr/lib/firmware/brcm

  cp -PR bcm_ampak/config/6335/fw_bcm4339a0_*.bin $INSTALL/usr/lib/firmware/brcm
  cp -P bcm_ampak/config/6335/nvram.txt $INSTALL/usr/lib/firmware/brcm/nvram_ap6335.txt
  cp -P bcm_ampak/config/6335/BT/bcm4335c0.hcd $INSTALL/usr/lib/firmware/brcm
}
