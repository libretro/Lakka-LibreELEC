# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="flashrom"
PKG_VERSION="1.2"
PKG_SHA256="e1f8d95881f5a4365dfe58776ce821dfcee0f138f75d0f44f8a3cd032d9ea42b"
PKG_LICENSE="GPL"
PKG_SITE="https://www.flashrom.org/Flashrom"
PKG_URL="https://download.flashrom.org/releases/${PKG_NAME}-v${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb-compat"
PKG_LONGDESC="flashrom is a utility for identifying, reading, writing, verifying and erasing flash chips. It is designed to flash BIOS/EFI/coreboot/firmware/optionROM images on mainboards, network/graphics/storage controller cards, and various other programmer devices."

PKG_MESON_OPTS_TARGET="-Dpciutils=false \
                       -Dusb=false \
                       -Dconfig_ft2232_spi=false \
                       -Dconfig_usbblaster_spi=false"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/sbin
    cp flashrom ${INSTALL}/usr/sbin
}
