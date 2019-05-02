# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="kernel-firmware"
PKG_VERSION="92e17d0dd2437140fab044ae62baf69b35d7d1fa"
PKG_SHA256="614aeecebe641a20fbc2825b6cd749d5c5528cba40a75503a5fd93321681e312"
PKG_LICENSE="other"
PKG_SITE="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/"
PKG_URL="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/$PKG_VERSION.tar.gz"
PKG_NEED_UNPACK="${PROJECT_DIR}/${PROJECT}/packages/${PKG_NAME} ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/packages/${PKG_NAME}"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="kernel-firmware: kernel related firmware"
PKG_TOOLCHAIN="manual"

# Install additional miscellaneous drivers
makeinstall_target() {
  FW_TARGET_DIR=$INSTALL/$(get_full_firmware_dir)

  if find_file_path firmwares/kernel-firmware.dat; then
    FW_LISTS="${FOUND_PATH}"
  else
    FW_LISTS="${PKG_DIR}/firmwares/any.dat ${PKG_DIR}/firmwares/${TARGET_ARCH}.dat"
  fi

  for fwlist in ${FW_LISTS}; do
    [ -f "${fwlist}" ] || continue

    while read -r fwline; do
      [ -z "${fwline}" ] && continue
      [[ ${fwline} =~ ^#.* ]] && continue
      [[ ${fwline} =~ ^[[:space:]] ]] && continue

      while read -r fwfile; do
        [ -d "${PKG_BUILD}/${fwfile}" ] && continue

        if [ -f "${PKG_BUILD}/${fwfile}" ]; then
          mkdir -p "$(dirname "${FW_TARGET_DIR}/${fwfile}")"
            cp -Lv "${PKG_BUILD}/${fwfile}" "${FW_TARGET_DIR}/${fwfile}"
        else
          echo "ERROR: Firmware file ${fwfile} does not exist - aborting"
          exit 1
        fi
      done <<< "$(cd ${PKG_BUILD} && eval "find "${fwline}"")"
    done < "${fwlist}"
  done

  # The following files are RPi specific and installed by brcmfmac_sdio-firmware-rpi instead.
  # They are also not required at all if the kernel is not suitably configured.
  if listcontains "${FIRMWARE}" "brcmfmac_sdio-firmware-rpi" || \
     ! grep -q "^CONFIG_BRCMFMAC_SDIO=y" $(kernel_config_path); then
    rm -fr $FW_TARGET_DIR/brcm/brcmfmac43430*-sdio.*
    rm -fr $FW_TARGET_DIR/brcm/brcmfmac43455*-sdio.*
  fi

  # brcm pcie firmware is only needed by x86_64
  [ "$TARGET_ARCH" != "x86_64" ] && rm -fr $FW_TARGET_DIR/brcm/*-pcie.*

  # Cleanup - which may be project or device specific
  find_file_path scripts/cleanup.sh && ${FOUND_PATH} ${FW_TARGET_DIR} || true
}
