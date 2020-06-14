# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="brcmfmac_sdio-firmware-rpi"
PKG_VERSION="39f45e47c480f46b334770b88a738f12cc00010c"
PKG_SHA256="8a830d67a3758f9453b10efc9592515289df9b8743ae1a05bc1fd046bde6969f"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/LibreELEC.tv"
PKG_URL="https://github.com/LibreELEC/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Firmware for brcm bluetooth chips used on RaspberryPi devices."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  DESTDIR=$INSTALL/$(get_kernel_overlay_dir) ./install
}

post_makeinstall_target() {
  # Install rpi btuart script to bring up Bluetooth
  mkdir -p $INSTALL/usr/bin
    cp -P $PKG_DIR/scripts/rpi-btuart $INSTALL/usr/bin
    cp -P $PKG_DIR/scripts/rpi-udev $INSTALL/usr/bin
}

post_install() {
  enable_service brcmfmac_sdio-firmware.service
}
