PKG_NAME="switch-gpu-profile"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_DEPENDS="Python"

make_target() {
  :
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp $PKG_DIR/scripts/gpu-profile $INSTALL/usr/bin
}

post_install() {
  enable_service switch-gpu-profile.service
}
