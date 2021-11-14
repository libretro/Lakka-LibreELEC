PKG_NAME="switch-gpu-profile"
PKG_VERSION="1.0"
PKG_DEPENDS_TARGET="Python3"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v ${PKG_DIR}/scripts/gpu-profile ${INSTALL}/usr/bin
}

post_install() {
  enable_service switch-gpu-profile.service
}
