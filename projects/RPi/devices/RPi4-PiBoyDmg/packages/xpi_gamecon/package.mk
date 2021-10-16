PKG_NAME="xpi_gamecon"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="xpi_gamecon driver for PiBoyDMG"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_DIR}/scripts/piboy-dmg-control.sh ${INSTALL}/usr/bin/
}

post_install() {
  enable_service xpi_gamecon_reboot.service
  enable_service xpi_gamecon_shutdown.service
  enable_service piboy-dmg-control.service
}
