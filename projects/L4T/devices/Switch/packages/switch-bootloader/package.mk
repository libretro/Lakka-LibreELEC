PKG_NAME="switch-bootloader"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="switch-u-boot:host linux cbfstool:host switch-u-boot:host"
PKG_TOOLCHAIN="manual"


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
  sed -i "s/@DISTRO_PATH@/${DISTRO_PATH}/g" ${PKG_BUILD}/boot.txt
  sed -i "s/@DISTRO_ID@/${ID}/g" ${PKG_BUILD}/boot.txt

  mkimage -A arm -T script -O linux -d ${PKG_BUILD}/boot.txt ${PKG_BUILD}/boot.scr

  cp ${PKG_DIR}/assets/uenv.txt ${PKG_BUILD}/
  sed -i "s/@DISTRO_PATH@/${DISTRO_PATH}/g" ${PKG_BUILD}/uenv.txt

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

