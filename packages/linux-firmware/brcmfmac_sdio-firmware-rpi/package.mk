# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="brcmfmac_sdio-firmware-rpi"
PKG_VERSION="883b72628de1d7efa45b421da0cbf175ac2374f8"
PKG_SHA256="0e7fcfe75a8990815a184dc55f8fdf5d0644d351a15a7aef865ff90ff4ca8eb4"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/LibreELEC.tv"
PKG_URL="https://github.com/LibreELEC/${PKG_NAME}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Firmware for brcm bluetooth chips used on RaspberryPi devices."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  DESTDIR=${INSTALL}/$(get_kernel_overlay_dir) ./install
}

post_makeinstall_target() {
  # Install rpi btuart script to bring up Bluetooth
  mkdir -p ${INSTALL}/usr/bin
    cp -P ${PKG_DIR}/scripts/rpi-btuart ${INSTALL}/usr/bin
    cp -P ${PKG_DIR}/scripts/rpi-udev ${INSTALL}/usr/bin
}

post_install() {
  enable_service brcmfmac_sdio-firmware.service
}
