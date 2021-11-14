PKG_NAME="switch-bootloader"
PKG_VERSION="1.0"
PKG_DEPENDS_TARGET="switch-u-boot linux"
#PKG_DEPENDS_TARGET="switch-coreboot linux"
PKG_TOOLCHAIN="make"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader/boot
  mkimage -A arm -T script -O linux -d ${PKG_DIR}/assets/boot.txt ${INSTALL}/usr/share/bootloader/boot/boot.scr

  cp -PRv ${PKG_DIR}/assets/splash.bmp ${INSTALL}/usr/share/bootloader/boot/splash.bmp
  cp -PRv ${PKG_DIR}/assets/Lakka.ini ${INSTALL}/usr/share/bootloader/boot/Lakka.ini
  #cp -PRv ${BUILD}/$PKG_NAME-$PKG_VERSION/boot.scr ${INSTALL}/usr/share/bootloader/boot/boot.scr
  cp -PRv ${PKG_DIR}/assets/coreboot.rom ${INSTALL}/usr/share/bootloader/boot/coreboot.rom
  cp -PRv ${PKG_DIR}/assets/uenv.txt ${INSTALL}/usr/share/bootloader/boot/uenv.txt
  cp -PRv ${PKG_DIR}/assets/uartb_logging.dtbo ${INSTALL}/usr/share/bootloader/boot/uartb_logging.dtbo
  cp -PRv ${PKG_DIR}/assets/icon_lakka_hue.bmp  ${INSTALL}/usr/share/bootloader/boot/
  cp -PRv ${PKG_DIR}/assets/icon_lakka.bmp  ${INSTALL}/usr/share/bootloader/boot/
  #cp -PRv ${BUILD}/switch-boot/coreboot.rom ${INSTALL}/usr/share/bootloader/boot/coreboot.rom
}
