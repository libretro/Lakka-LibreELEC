PKG_NAME="xpi_gamecon"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_LONGDESC="xpi_gamecon driver for PiBoyDMG"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"
PKG_IS_KERNEL_PKG="yes"

make_target() {
  kernel_make -C $(kernel_path) M=${PKG_BUILD} modules
}

makeinstall_target() {
  mkdir -p ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}
    cp -v ${PKG_BUILD}/*.ko ${INSTALL}/$(get_full_module_dir)/${PKG_NAME}/
  mkdir -p ${INSTALL}/usr/lib/modules-load.d
    echo xpi_gamecon > ${INSTALL}/usr/lib/modules-load.d/xpi_gamecon.conf
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_DIR}/scripts/piboy-dmg-control.sh ${INSTALL}/usr/bin/
}

post_install() {
  enable_service xpi_gamecon_reboot.service
  enable_service xpi_gamecon_shutdown.service
  enable_service piboy-dmg-control.service
}
