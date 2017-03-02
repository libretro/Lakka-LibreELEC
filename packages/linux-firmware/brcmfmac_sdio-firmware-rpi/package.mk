################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="brcmfmac_sdio-firmware-rpi"
PKG_VERSION="0.1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/LibreELEC.tv"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_SHORTDESC="brcmfmac_sdio-firmware: firmware for brcm bluetooth chips used on RaspberryPi devices"
PKG_LONGDESC="Firmware for Broadcom Bluetooth chips used on RaspberryPi devices, and brcm-patchram-plus that downloads a patchram files in the HCD format to the Bluetooth based silicon and combo chips and other utility functions."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing todo
}

makeinstall_target() {
  DESTDIR=$INSTALL/usr ./install
}

post_makeinstall_target() {
  # Install rpi btuart script to bring up Bluetooth
  mkdir -p $INSTALL/usr/bin
    cp -P $PKG_DIR/scripts/rpi-btuart $INSTALL/usr/bin
}

post_install() {
  enable_service brcmfmac_sdio-firmware.service
}
