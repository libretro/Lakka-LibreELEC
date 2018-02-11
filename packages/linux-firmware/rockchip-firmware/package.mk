################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

PKG_NAME="rockchip-firmware"
PKG_VERSION="firmware"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/rockchip-linux"
PKG_URL=""
PKG_DEPENDS_TARGET="rkbin rfkill"
PKG_SECTION="firmware"
PKG_SHORTDESC="rockchip firmware"
PKG_LONGDESC="rockchip firmware"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -v $(get_build_dir rkbin)/firmware/bin/rtk_hciattach $INSTALL/usr/bin

  mkdir -p $INSTALL/$(get_full_firmware_dir)/rtlbt
    cp -v $(get_build_dir rkbin)/firmware/bluetooth/rtl8723b_* $INSTALL/$(get_full_firmware_dir)/rtlbt

  mkdir -p $INSTALL/$(get_full_firmware_dir)/brcm
    cp -v $(get_build_dir rkbin)/firmware/bluetooth/BCM4354A2.hcd $INSTALL/$(get_full_firmware_dir)/brcm
    cp -v $(get_build_dir rkbin)/firmware/wifi/fw_bcm4356a2_ag.bin $INSTALL/$(get_full_firmware_dir)/brcm
    cp -v $(get_build_dir rkbin)/firmware/wifi/nvram_ap6356.txt $INSTALL/$(get_full_firmware_dir)/brcm
}
