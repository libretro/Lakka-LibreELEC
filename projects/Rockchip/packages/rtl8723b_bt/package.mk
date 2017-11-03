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

PKG_NAME="rtl8723b_bt"
PKG_VERSION="firmware"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/rockchip-linux/rk-rootfs-build/tree/master/overlay-firmware/lib/firmware/rtlbt"
PKG_URL=""
PKG_DEPENDS_TARGET="rfkill"
PKG_SECTION="firmware"
PKG_SHORTDESC="rtl8723b_bt firmware"
PKG_LONGDESC="rtl8723b_bt firmware"
PKG_AUTORECONF="no"

make_target() {
  : # nothing
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp rtk_hciattach $INSTALL/usr/bin

  mkdir -p $INSTALL/$(get_full_firmware_dir)/rtlbt
    cp rtl8723b_* $INSTALL/$(get_full_firmware_dir)/rtlbt
}

post_install() {
  enable_service rtl8723b_bt.service
}
