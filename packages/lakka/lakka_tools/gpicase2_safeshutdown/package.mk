PKG_NAME="gpicase2_safeshutdown"
PKG_VERSION="1.0"
PKG_ARCH="aarch64"
PKG_DEPENDS_TARGET="Python3 gpiozero colorzero"
PKG_SECTION="system"
PKG_LONGDESC="GPICase 2 safe shutdown script."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_DIR}/scripts/* ${INSTALL}/usr/bin
}

post_install() {
  enable_service gpicase2-safeshutdown.service
}
