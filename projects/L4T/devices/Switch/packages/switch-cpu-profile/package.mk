PKG_NAME="switch-cpu-profile"
PKG_VERSION="2.0"
PKG_DEPENDS_TARGET="Python3"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_DIR}/scripts/cpu-profile ${INSTALL}/usr/bin
    chmod +x ${INSTALL}/usr/bin/cpu-profile
}

post_install() {
  enable_service switch-cpu-profile.service
}
