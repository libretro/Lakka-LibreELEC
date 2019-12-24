# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019 Team LibreELEC (https://libreelec.tv)

PKG_NAME="flashrom"
PKG_VERSION="1.1"
PKG_SHA256="aeada9c70c22421217c669356180c0deddd0b60876e63d2224e3260b90c14e19"
PKG_LICENSE="GPL"
PKG_SITE="https://www.flashrom.org/Flashrom"
PKG_URL="https://download.flashrom.org/releases/${PKG_NAME}-v${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb-compat"
PKG_LONGDESC="flashrom is a utility for identifying, reading, writing, verifying and erasing flash chips. It is designed to flash BIOS/EFI/coreboot/firmware/optionROM images on mainboards, network/graphics/storage controller cards, and various other programmer devices."

PKG_MAKE_OPTS_TARGET="PREFIX=/usr \
                      CONFIG_ENABLE_LIBPCI_PROGRAMMERS=no \
                      CONFIG_FT2232_SPI=no \
                      CONFIG_USBBLASTER_SPI=no \
                      CONFIG_JLINK_SPI=no"
PKG_MAKEINSTALL_OPTS_TARGET="${PKG_MAKE_OPTS_TARGET}"

post_makeinstall_target() {
  rm -fr ${INSTALL}/usr/share/man
}
