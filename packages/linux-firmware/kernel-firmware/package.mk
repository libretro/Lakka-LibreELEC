################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="kernel-firmware"
PKG_VERSION="8c1e439"
PKG_SHA256="7fc282816b11af92e28f1c2624698d62163c4db259011da454d036c3ff98aa2e"
PKG_ARCH="any"
PKG_LICENSE="other"
PKG_SITE="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/"
PKG_URL="https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/snapshot/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="$PKG_VERSION"
PKG_NEED_UNPACK="${PROJECT_DIR}/${PROJECT}/packages/${PKG_NAME} ${PROJECT_DIR}/${PROJECT}/devices/${DEVICE}/packages/${PKG_NAME}"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="kernel-firmware: kernel related firmware"
PKG_LONGDESC="kernel-firmware: kernel related firmware"
PKG_TOOLCHAIN="manual"

# Install additional miscellaneous drivers
makeinstall_target() {
  FW_TARGET_DIR=$INSTALL/$(get_full_firmware_dir)

  if find_file_path firmwares/kernel-firmware.dat; then
    FW_LISTS="${FOUND_FILE}"
  else
    FW_LISTS="${PKG_DIR}/firmwares/any.dat ${PKG_DIR}/firmwares/${TARGET_ARCH}.dat"
  fi

  for fwlist in ${FW_LISTS}; do
    [ -f ${fwlist} ] || continue
    while read -r fwline; do
      [ -z "${fwline}" ] && continue
      [[ ${fwline} =~ ^#.* ]] && continue
      [[ ${fwline} =~ ^[[:space:]] ]] && continue

      for fwfile in $(cd ${PKG_BUILD} && eval "find ${fwline}"); do
        [ -d ${PKG_BUILD}/${fwfile} ] && continue

        if [ -f ${PKG_BUILD}/${fwfile} ]; then
          mkdir -p $(dirname ${FW_TARGET_DIR}/${fwfile})
            cp -Lv ${PKG_BUILD}/${fwfile} ${FW_TARGET_DIR}/${fwfile}
        else
          echo "ERROR: Firmware file ${fwfile} does not exist - aborting"
          exit 1
        fi
      done
    done < ${fwlist}
  done

  # The following files are RPi specific and installed by brcmfmac_sdio-firmware-rpi instead
  rm -fr $FW_TARGET_DIR/brcm/brcmfmac43430*-sdio.bin
  rm -fr $FW_TARGET_DIR/brcm/brcmfmac43455*-sdio.bin

  # Cleanup - which may be project or device specific
  find_file_path scripts/cleanup.sh && ${FOUND_PATH} ${FW_TARGET_DIR} || true
}
