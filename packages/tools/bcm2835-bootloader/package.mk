# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcm2835-bootloader"
PKG_VERSION="53f4941b7bb2512e07fa7c6baec29cbee4889848"
PKG_SHA256="bb61b6baec79e2d0b4a4a63d62064c5a6d1e9baf7fd7bfb6810454893ab37e76"
PKG_ARCH="arm aarch64"
PKG_LICENSE="nonfree"
PKG_SITE="http://www.broadcom.com"
PKG_URL="${DISTRO_SRC}/${PKG_NAME}-${PKG_VERSION}.tar.xz"

# for Lakka we use the upstream repo tag
if [ "${DISTRO}" = "Lakka" ]; then
  PKG_VERSION="1.20220308" # for kernel 5.10.103
  PKG_SHA256="70638d515fd16aee31a963d2693e6ef5963b22420db585e2e99a0b62a43fd287"
  PKG_URL="https://github.com/raspberrypi/firmware/archive/refs/tags/${PKG_VERSION}.tar.gz"
fi

PKG_DEPENDS_TARGET="toolchain linux bcmstat"
PKG_LONGDESC="bcm2835-bootloader: Tool to create a bootable kernel for RaspberryPi"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  # upstream repo stores the firmware file in 'boot' subfolder
  if [ "${DISTRO}" = "Lakka" ]; then
    PKG_BOOT_FOLDER="boot"
  else
    PKG_BOOT_FOLDER="."
  fi

  mkdir -p ${INSTALL}/usr/share/bootloader
    cp -PRv ${PKG_BOOT_FOLDER}/LICENCE* ${INSTALL}/usr/share/bootloader
    cp -PRv ${PKG_BOOT_FOLDER}/bootcode.bin ${INSTALL}/usr/share/bootloader
    if [ "${DEVICE:0:4}" = "RPi4" ]; then
      cp -PRv ${PKG_BOOT_FOLDER}/fixup4x.dat ${INSTALL}/usr/share/bootloader/fixup.dat
      cp -PRv ${PKG_BOOT_FOLDER}/start4x.elf ${INSTALL}/usr/share/bootloader/start.elf
    else
      cp -PRv ${PKG_BOOT_FOLDER}/fixup_x.dat ${INSTALL}/usr/share/bootloader/fixup.dat
      cp -PRv ${PKG_BOOT_FOLDER}/start_x.elf ${INSTALL}/usr/share/bootloader/start.elf
    fi

    find_file_path bootloader/update.sh ${PKG_DIR}/files/update.sh && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    find_file_path bootloader/canupdate.sh && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader

    find_file_path config/distroconfig.txt ${PKG_DIR}/files/distroconfig.txt && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader
    find_file_path config/config.txt ${PKG_DIR}/files/config.txt && cp -PRv ${FOUND_PATH} ${INSTALL}/usr/share/bootloader

    if [ "${DISTRO}" = "Lakka" ]; then
      echo "disable_splash=1" >> ${INSTALL}/usr/share/bootloader/distroconfig.txt
      echo "dtparam=audio=on" >> ${INSTALL}/usr/share/bootloader/distroconfig.txt
      if [ "${DEVICE}" = "RPi4" -o "${DEVICE}" = "RPi4-PiBoyDmg" ]; then
        sed -e "s|^gpu_mem=.*$|gpu_mem=384|g" -i ${INSTALL}/usr/share/bootloader/config.txt
      elif [ "${DEVICE}" = "RPi4-RetroDreamer" ]; then
        sed -e "s|^gpu_mem=.*$|gpu_mem=256|g" -i ${INSTALL}/usr/share/bootloader/config.txt
      else
        sed -e "s|^gpu_mem=.*$|gpu_mem=128|g" -i ${INSTALL}/usr/share/bootloader/config.txt
      fi
      echo "force_turbo=0" >> ${INSTALL}/usr/share/bootloader/config.txt
    fi
}
