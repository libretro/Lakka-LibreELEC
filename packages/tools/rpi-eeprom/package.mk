# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rpi-eeprom"
PKG_VERSION="6b14e84a2fb2e1f7220a404f65e7e0985f07c9e5"
PKG_SHA256="3907711bb2ff78a0e9120709b72b04d6d010f93f79d525af0454d3d27a772aca"
PKG_LICENSE="BSD-3/custom"
PKG_SITE="https://github.com/raspberrypi/rpi-eeprom"
PKG_URL="https://github.com/raspberrypi/rpi-eeprom/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="pciutils"
PKG_LONGDESC="rpi-eeprom: firmware, config and scripts to update RPi4 SPI bootloader"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  
  if [ "${DEVICE}" = "RPi4" ]; then
    _variant="2711"
  else
    _variant="2712"
  fi

  DESTDIR=${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/raspberrypi/bootloader-${_variant}

  mkdir -p ${DESTDIR}
    _dirs="default latest"

    for _maindir in ${_dirs}; do
      for _dir in ${PKG_BUILD}/firmware-${_variant}/${_maindir} ${PKG_BUILD}/firmware-${_variant}/${_maindir}-*; do
        [ -d "${_dir}" ] || continue

        _basedir="$(basename "${_dir}")"

        mkdir -p ${DESTDIR}/${_basedir}
          cp -PRv ${_dir}/recovery.bin ${DESTDIR}/${_basedir}

          # Bootloader SPI
          PKG_FW_FILE="$(ls -1 /${_dir}/pieeprom-* 2>/dev/null | tail -1)"
          [ -n "${PKG_FW_FILE}" ] && cp -PRv "${PKG_FW_FILE}" ${DESTDIR}/${_basedir}

          if [ "${DEVICE}" = "RPi4" ]; then
            # VIA USB3
            PKG_FW_FILE="$(ls -1 ${_dir}/vl805-*.bin 2>/dev/null | tail -1)"
            [ -n "${PKG_FW_FILE}" ] && cp -PRv "${PKG_FW_FILE}" ${DESTDIR}/${_basedir}
          fi
      done
    done

    # also create legacy naming symlinks
    ln -s default ${DESTDIR}/critical
    ln -s latest ${DESTDIR}/stable

  mkdir -p ${INSTALL}/usr/bin
    cp -PRv ${PKG_DIR}/source/rpi-eeprom-update ${INSTALL}/usr/bin
    cp -PRv ${PKG_BUILD}/rpi-eeprom-update ${INSTALL}/usr/bin/.rpi-eeprom-update.real
    cp -PRv ${PKG_BUILD}/rpi-eeprom-config ${INSTALL}/usr/bin
    cp -PRv ${PKG_BUILD}/rpi-eeprom-digest ${INSTALL}/usr/bin

  mkdir -p ${INSTALL}/etc/default
    cp -PRv ${PKG_DIR}/config/* ${INSTALL}/etc/default
}
