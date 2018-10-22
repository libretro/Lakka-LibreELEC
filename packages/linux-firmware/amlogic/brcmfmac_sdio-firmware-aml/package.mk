# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="brcmfmac_sdio-firmware-aml"
PKG_VERSION="0.1"
PKG_SHA256="37e19eb005882793d26d0def8704417b21beb1c24d2b4489715e4ed7e7818776"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/LibreELEC.tv"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="brcmfmac_sdio-firmware: firmware for brcm bluetooth chips used in some Amlogic based devices"
PKG_LONGDESC="Firmware for Broadcom Bluetooth devices used in some Amlogic based devices, and brcm-patchram-plus that downloads a patchram files in the HCD format to the Bluetooth based silicon and combo chips and other utility functions."

makeinstall_target() {
  DESTDIR=$INSTALL FWDIR=$INSTALL/$(get_kernel_overlay_dir) make install
}
