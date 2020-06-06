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

PKG_NAME="wandboard-firmware"
PKG_VERSION="0.1"
PKG_ARCH="any"
PKG_LICENSE="Free-to-use"
PKG_SITE=""
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain kernel-firmware wlan-firmware dvb-firmware brcmfmac_sdio-firmware"
PKG_SECTION="firmware"
PKG_SHORTDESC="wandboard-firmware: firmware for Wandboard"
PKG_LONGDESC="wandboard-firmware: Firmware for Wandboard"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing todo
}

makeinstall_target() {
  : # nothing todo
}
