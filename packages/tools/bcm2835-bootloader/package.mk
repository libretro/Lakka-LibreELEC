# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-bootloader"
PKG_VERSION="1711f63174c5bfe147cc903af14e99a36938c105"
PKG_SHA256="625bbfb714f4b9dd38b0dfd0001e8faea22018196604b4dadef8190c051acc49"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
PKG_URL="${DISTRO_SRC}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain linux bcmstat"
PKG_LONGDESC="bcm2835-bootloader: Tool to create a bootable kernel for RaspberryPi"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader
    cp -PRv LICENCE* ${INSTALL}/usr/share/bootloader
    cp -PRv bootcode.bin ${INSTALL}/usr/share/bootloader
    if [ "${DEVICE}" = "RPi4" ]; then
      cp -PRv fixup4x.dat ${INSTALL}/usr/share/bootloader/fixup.dat
      cp -PRv start4x.elf ${INSTALL}/usr/share/bootloader/start.elf
    else
      cp -PRv fixup_x.dat ${INSTALL}/usr/share/bootloader/fixup.dat
      cp -PRv start_x.elf ${INSTALL}/usr/share/bootloader/start.elf
    fi

    find_file_path bootloader/update.sh ${PKG_DIR}/files/update.sh && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    find_file_path bootloader/canupdate.sh && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader

    find_file_path config/distroconfig.txt ${PKG_DIR}/files/distroconfig.txt && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    find_file_path config/config.txt ${PKG_DIR}/files/config.txt && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
}
