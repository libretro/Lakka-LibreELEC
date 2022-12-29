PKG_NAME="switch-bootloader"
PKG_VERSION="2.0"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="switch-u-boot:host switch-u-boot:target switch-atf:target"
PKG_TOOLCHAIN="manual"


if [ "${DISTRO}" = "Lakka" ]; then
  DISTRO_PATH="lakka"
  DISTRO_ICON="icon_lakka_hue.bmp"
  HEKATE_SPLASH="splash_lakka.bmp"
  ID="SWR-LAK"
elif [ "${DISTRO}" = "LibreELEC" ]; then
  DISTRO_PATH="libreelec"
  DISTRO_ICON="icon_libreelec_hue.bmp"
  HEKATE_SPLASH="splash_libreelec.bmp"
  ID="SWR-LIB"
else
  echo "Unknown distro, expect issues"
fi


make_target() {
  cat << EOF > ${PKG_BUILD}/${DISTRO}.ini
[${DISTRO}]
l4t=1
boot_prefixes=${DISTRO_PATH}/boot/
logopath=${DISTRO_PATH}/boot/splash.bmp
id=${ID}
icon=${DISTRO_PATH}/boot/${DISTRO_ICON}
EOF

  cp ${PKG_DIR}/assets/README_CONFIG.txt ${PKG_BUILD}/
     sed -i "s/@DISTRO_PATH@/${DISTRO_PATH}/g" ${PKG_BUILD}/README_CONFIG.txt
     sed -i "s/@DISTRO_ID@/${ID}/g" ${PKG_BUILD}/README_CONFIG.txt
     sed -i "s/@DISTRO@/${DISTRO}/g" ${PKG_BUILD}/README_CONFIG.txt
  cp ${PKG_DIR}/assets/boot.txt ${PKG_BUILD}/
    sed -i "s/@DISTRO_PATH@/${DISTRO_PATH}/g" ${PKG_BUILD}/boot.txt
    sed -i "s/@DISTRO_ID@/${ID}/g" ${PKG_BUILD}/boot.txt

  mkimage -A arm -T script -O linux -d ${PKG_BUILD}/boot.txt ${PKG_BUILD}/boot.scr
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader/boot

  cp -Prv ${PKG_BUILD}/boot.scr ${INSTALL}/usr/share/bootloader/boot/boot.scr
  cp -PRv ${PKG_BUILD}/${DISTRO}.ini ${INSTALL}/usr/share/bootloader/boot/${DISTRO}.ini
   cp -PRv ${PKG_BUILD}/README_CONFIG.txt ${INSTALL}/usr/share/bootloader/boot/README_CONFIG.txt
  cp -PRv ${PKG_DIR}/assets/${HEKATE_SPLASH} ${INSTALL}/usr/share/bootloader/boot/splash.bmp
  if [ "${DISTRO}" = "Lakka" ]; then
    cp -PRv ${PKG_DIR}/assets/${DISTRO_ICON}  ${INSTALL}/usr/share/bootloader/boot/
    DISTRO_FOLDER_NAME="lakka"
  elif [ "${DISTRO}" = "LibreELEC" ]; then
    DISTRO_FOLDER_NAME="libreelec"
  fi
cat << EOF >> ${INSTALL}/usr/share/bootloader/update.sh
#/bin/sh
[ -z "\${BOOT_ROOT}" ] && BOOT_ROOT="/flash"
[ -z "\${SYSTEM_ROOT}" ] && SYSTEM_ROOT=""
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot.scr" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot.scr
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/coreboot.rom" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/coreboot.rom
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/uenv.txt" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/uenv.txt
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/tegra210-icosa.dtb" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/tegra210-icosa.dtb
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/uartb_logging.dtbo" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/uartb_logging.dtbo
[ -f "\${BOOT_ROOT}/bootloader/ini/${DISTRO}.ini" ] && rm \${BOOT_ROOT}/bootloader/ini/${DISTRO}.ini
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/nx-plat.dtimg" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/nx-plat.dtimg
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot/boot.scr" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot/boot.scr
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot/bl31.bin" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot/bl31.bin
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot/bl33.bin" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot/bl33.bin
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/nx-plat.dtimg" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/nx-plat.dtimg
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/${DISTRO_ICON}" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/${DISTRO_ICON}
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/splash.bmp" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/splash.bmp
[ -f "\${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/README_CONFIG.txt" ] && rm \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/README_CONFIG.txt
mkdir -p \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot
cp \${SYSTEM_ROOT}/usr/share/bootloader/boot/nx-plat.dtimg \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/
cp \${SYSTEM_ROOT}/usr/share/bootloader/boot/README_CONFIG.txt \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/
cp \${SYSTEM_ROOT}/usr/share/bootloader/boot/boot.scr \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot/
cp \${SYSTEM_ROOT}/usr/share/bootloader/boot/bl31.bin \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot/
cp \${SYSTEM_ROOT}/usr/share/bootloader/boot/bl33.bin \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot/
cp \${SYSTEM_ROOT}/usr/share/bootloader/boot/${DISTRO}.ini \${BOOT_ROOT}/bootloader/ini/${DISTRO}.ini
cp \${SYSTEM_ROOT}/usr/share/bootloader/boot/splash.bmp \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot/
cp \${SYSTEM_ROOT}/usr/share/bootloader/boot/${DISTRO_ICON} \${BOOT_ROOT}/${DISTRO_FOLDER_NAME}/boot/

EOF

chmod +x ${INSTALL}/usr/share/bootloader/update.sh

}

