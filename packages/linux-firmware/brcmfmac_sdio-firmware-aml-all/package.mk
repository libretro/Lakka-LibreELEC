################################################################################
#      This file is part of LibreELEC - https://LibreELEC.tv
#      Copyright (C) 2016 Team LibreELEC
#      Copyright (C) 2016 kszaq
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

PKG_NAME="brcmfmac_sdio-firmware-aml-all"
PKG_VERSION="f9d6101"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kszaq/brcmfmac_sdio-firmware-aml"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="brcmfmac_sdio-firmware-aml-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="firmware"
PKG_SHORTDESC="brcmfmac_sdio-firmware-aml: firmware for brcm bluetooth chips used in some Amlogic based devices"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_makeinstall_target() {
  cd $INSTALL/usr/lib/firmware/brcm
  for f in *.hcd; do
    ln -sr $f $(grep --text -o 'BCM\S*' $f).hcd 2>/dev/null || true
    ln -sr $f $(grep --text -o 'BCM\S*' $f | cut -c4-).hcd 2>/dev/null || true
    ln -sr $f $(echo $f | sed -r 's/[^.]*/\U&/') 2>/dev/null || true
    ln -sr bcm4335_V0343.0353.hcd BCM4335A0.hcd 2>/dev/null || true
  done
}
