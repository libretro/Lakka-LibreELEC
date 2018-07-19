# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="brcmfmac_sdio-firmware-all-aml"
PKG_VERSION="02b8502"
PKG_SHA256="899f1da77994d337cfe57ec3f38cc13247769d8df6c56b2541f5b8fea6438f16"
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
