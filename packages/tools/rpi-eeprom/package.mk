# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rpi-eeprom"
PKG_VERSION="718820bcebd21d4a619fa262d9b9cf3acbf110f8"
PKG_SHA256="aa7ad6e93f31c48d43240b1695774a882c338b5945a2f4951fdbc1e1136b0688"
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
    _dirs="critical stable"
    [ "$LIBREELEC_VERSION" = "devel" ] && _dirs+=" beta"

    for _maindir in ${_dirs}; do
      for _dir in ${PKG_BUILD}/firmware/${_maindir} ${PKG_BUILD}/firmware/{_maindir}-*; do
        [ -d "${_dir}" ] || continue

	_basedir="$(basename "${_dir}")"

        mkdir -p ${DESTDIR}/${_basedir}
          cp -PRv ${_dir}/recovery.bin ${DESTDIR}/${_basedir}

          # Bootloader SPI
          PKG_FW_FILE="$(ls -1 /${_dir}/pieeprom-* 2>/dev/null | tail -1)"
          [ -n "${PKG_FW_FILE}" ] && cp -PRv "${PKG_FW_FILE}" ${DESTDIR}/${_basedir}

          # VIA USB3
          PKG_FW_FILE="$(ls -1 ${_dir}/vl805-*.bin 2>/dev/null | tail -1)"
          [ -n "${PKG_FW_FILE}" ] && cp -PRv "${PKG_FW_FILE}" ${DESTDIR}/${_basedir}
      done
    done

  mkdir -p ${INSTALL}/usr/bin
    cp -PRv ${PKG_DIR}/source/rpi-eeprom-update ${INSTALL}/usr/bin
    cp -PRv ${PKG_BUILD}/rpi-eeprom-update ${INSTALL}/usr/bin/.rpi-eeprom-update.real
    cp -PRv ${PKG_BUILD}/rpi-eeprom-config ${INSTALL}/usr/bin
    cp -PRv ${PKG_BUILD}/firmware/vl805 ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/etc/default
    cp -PRv ${PKG_DIR}/config/* ${INSTALL}/etc/default
}
