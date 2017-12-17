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

PKG_NAME="brcmfmac_sdio-firmware-all-aml"
PKG_VERSION="f9d6101"
PKG_SHA256="4676dfb1053795fd4c3c3ba59430da251d273202f016a9fdc13f22e12ac34947"
PKG_ARCH="arm aarch64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kszaq/brcmfmac_sdio-firmware-aml"
PKG_URL="https://github.com/kszaq/brcmfmac_sdio-firmware-aml/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="brcmfmac_sdio-firmware-aml-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_SHORTDESC="brcmfmac_sdio-firmware: firmware for brcm bluetooth chips used in some Amlogic based devices"
PKG_LONGDESC="Firmware for Broadcom Bluetooth devices used in some Amlogic based devices, and brcm-patchram-plus that downloads a patchram files in the HCD format to the Bluetooth based silicon and combo chips and other utility functions."

post_makeinstall_target() {
  cd $INSTALL/$(get_full_firmware_dir)/brcm
  for f in *.hcd; do
    ln -sr $f $(grep --text -o 'BCM\S*' $f).hcd 2>/dev/null || true
    ln -sr $f $(grep --text -o 'BCM\S*' $f | cut -c4-).hcd 2>/dev/null || true
    ln -sr $f $(echo $f | sed -r 's/[^.]*/\U&/') 2>/dev/null || true
    ln -sr bcm4335_V0343.0353.hcd BCM4335A0.hcd 2>/dev/null || true
  done
}
