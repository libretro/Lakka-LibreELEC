################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="switch-bootloader"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="switch-u-boot:host linux cbfstool:host switch-u-boot:host"
#PKG_DEPENDS_TARGET="switch-coreboot linux"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "${DISTRO}" = "Lakka" ]; then
  DISTRO_PATH="lakka"
  DISTRO_ICON="icon_lakka_hue.bmp"
  HEKATE_SPLASH="splash_lakka.bmp"
  ID="SWR-LAK"
  UBOOT_FILE="u-boot-lakka.elf"
elif [ "${DISTRO}" = "LibreELEC" ]; then
  DISTRO_PATH="libreelec"
  DISTRO_ICON="icon_libreelec_hue.bmp"
  HEKATE_SPLASH="splash_libreelec.bmp"
  ID="SWR-LIB"
  UBOOT_FILE="u-boot-libreelec.elf"
else
  echo "Unknown distro, expect issues"
fi


make_target() {
  cat << EOF > ${PKG_BUILD}/${DISTRO}.ini
[${DISTRO}]
payload=${DISTRO_PATH}/coreboot.rom
logopath=${DISTRO_PATH}/splash.bmp
id=${ID}
icon=${DISTRO_PATH}/${DISTRO_ICON}
EOF


  cp ${PKG_DIR}/assets/boot.txt ${PKG_BUILD}/
  sed -i "s/DISTRO_PATH/${DISTRO_PATH}/g" ${PKG_BUILD}/boot.txt
  sed -i "s/DISTRO_ID/${ID}/g" ${PKG_BUILD}/boot.txt

  mkimage -A arm -T script -O linux -d ${PKG_BUILD}/boot.txt ${PKG_BUILD}/boot.scr

  cp ${PKG_DIR}/assets/uenv.txt ${PKG_BUILD}/
  sed -i "s/DISTRO_PATH/${DISTRO_PATH}/g" ${PKG_BUILD}/uenv.txt

  cp ${PKG_DIR}/assets/coreboot.rom ${PKG_BUILD}/
  cbfstool "${PKG_BUILD}/coreboot.rom" remove -v -n fallback/payload
  cbfstool "${PKG_BUILD}/coreboot.rom" add-payload -v -n fallback/payload  -f "${PKG_DIR}/assets/${UBOOT_FILE}" -c lzma


}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader/boot

  cp -Prv ${PKG_BUILD}/boot.scr ${INSTALL}/usr/share/bootloader/boot/boot.scr
  cp -PRv ${PKG_BUILD}/${DISTRO}.ini ${INSTALL}/usr/share/bootloader/boot/${DISTRO}.ini
  cp -PRv ${PKG_BUILD}/coreboot.rom ${INSTALL}/usr/share/bootloader/boot/coreboot.rom
  cp -PRv ${PKG_BUILD}/uenv.txt ${INSTALL}/usr/share/bootloader/boot/uenv.txt
  cp -PRv ${PKG_DIR}/assets/uartb_logging.dtbo ${INSTALL}/usr/share/bootloader/boot/uartb_logging.dtbo
  cp -PRv ${PKG_DIR}/assets/${HEKATE_SPLASH} ${INSTALL}/usr/share/bootloader/boot/splash.bmp
  if [ "${DISTRO}" = "Lakka" ]; then
    cp -PRv ${PKG_DIR}/assets/${DISTRO_ICON}  ${INSTALL}/usr/share/bootloader/boot/
  fi
}

