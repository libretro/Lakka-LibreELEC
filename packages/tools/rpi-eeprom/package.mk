# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rpi-eeprom"
PKG_VERSION="ffec4bd48ff2ab753da10bd42b2fd7b904d8dca5"
PKG_SHA256="94eba989f3776c6d2f06cf021fffb1cb4c2f550fa325e5a08cab2fdd4a4e00bd"
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
    mkdir -p ${DESTDIR}/${_dir}
      cp -PRv ${PKG_BUILD}/firmware/recovery.bin ${DESTDIR}

    _dirs="critical"
    [ "$LIBREELEC_VERSION" = "devel" ] && _dirs+=" beta"
    for _dir in ${_dirs}; do
      if [ -n "$(ls -1 ${PKG_BUILD}/firmware/${_dir}/pieeprom-* 2>/dev/null)" ]; then
        mkdir -p ${DESTDIR}/${_dir}
          cp -PRv $(ls -1 ${PKG_BUILD}/firmware/${_dir}/pieeprom-* | tail -1) ${DESTDIR}/${_dir}
      fi
    done

  mkdir -p ${INSTALL}/usr/bin
    cp -PRv ${PKG_DIR}/source/rpi-eeprom-update ${INSTALL}/usr/bin
    cp -PRv ${PKG_BUILD}/rpi-eeprom-update ${INSTALL}/usr/bin/.rpi-eeprom-update.real
    cp -PRv ${PKG_BUILD}/rpi-eeprom-config ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/etc/default
    cp -PRv ${PKG_DIR}/config/* ${INSTALL}/etc/default
}
