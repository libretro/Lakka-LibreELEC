# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rpi-eeprom"
PKG_VERSION="16abe98714609b13e44ffeefc01bbeb3b6cd681e"
PKG_SHA256="0e3c3db7b4387f07787493bd1f05c2bbcd4f1b3b383f6f6fe8d25fd5f786392c"
PKG_ARCH="arm"
PKG_LICENSE="BSD-3/custom"
PKG_SITE="https://github.com/raspberrypi/rpi-eeprom"
PKG_URL="https://github.com/raspberrypi/rpi-eeprom/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="flashrom"
PKG_LONGDESC="rpi-eeprom: firmware, config and scripts to update RPi4 SPI bootloader"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  DESTDIR=${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/raspberrypi/bootloader

  mkdir -p ${DESTDIR}
    _dirs="critical"
    [ "$LIBREELEC_VERSION" = "devel" ] && _dirs+=" beta"
    for _dir in ${_dirs}; do
      mkdir -p ${DESTDIR}/${_dir}
        cp -PRv ${PKG_BUILD}/firmware/${_dir}/recovery.bin ${DESTDIR}/${_dir}

        # Bootloader SPI
        PKG_FW_FILE="$(ls -1 ${PKG_BUILD}/firmware/${_dir}/pieeprom-* 2>/dev/null | tail -1)"
        [ -n "${PKG_FW_FILE}" ] && cp -PRv "${PKG_FW_FILE}" ${DESTDIR}/${_dir}

        # VIA USB3
        if [ -f ${PKG_BUILD}/firmware/${_dir}/vl805.latest ]; then
          PKG_FW_FILE="$(tail -1 ${PKG_BUILD}/firmware/${_dir}/vl805.latest)"
          cp -PRv ${PKG_BUILD}/firmware/${_dir}/vl805-${PKG_FW_FILE}.bin ${DESTDIR}/${_dir}
          cp -PRv ${PKG_BUILD}/firmware/${_dir}/vl805.latest ${DESTDIR}/${_dir}
        fi
    done

  mkdir -p ${INSTALL}/usr/bin
    cp -PRv ${PKG_DIR}/source/rpi-eeprom-update ${INSTALL}/usr/bin
    cp -PRv ${PKG_BUILD}/rpi-eeprom-update ${INSTALL}/usr/bin/.rpi-eeprom-update.real
    cp -PRv ${PKG_BUILD}/rpi-eeprom-config ${INSTALL}/usr/bin
    cp -PRv ${PKG_BUILD}/firmware/vl805 ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/etc/default
    cp -PRv ${PKG_DIR}/config/* ${INSTALL}/etc/default
}
