PKG_NAME="odin-bootloader"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="odin-bootloader:init"
PKG_DEPENDS_INIT="plymouth-lite:init"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/share/bootloader/boot/
  cp -Prv ${PKG_DIR}/files/boot/* ${INSTALL}/usr/share/bootloader/boot/
}

makeinstall_init() {
  mkdir -p ${INSTALL}/splash
  if [ "${DISTRO}" = "Lakka" ]; then
    cp ${PKG_DIR}/initramfs/splash/splash-1080-lakka.png ${INSTALL}/splash/splash-1080.png
  elif [ "${DISTRO}" = "LibreELEC" ]; then
    cp ${PKG_DIR}/initramfs/splash/splash-1080-libreelec.png ${INSTALL}/splash/splash-1080.png
  fi
}
