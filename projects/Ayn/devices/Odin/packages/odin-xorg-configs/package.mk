PKG_NAME="odin-xorg-configs"
PKG_VERSION="1.0"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="xorg-server:target"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/etc/X11/xorg.conf.d
  cp -Prv ${PKG_DIR}/files/*.conf ${INSTALL}/etc/X11/xorg.conf.d/
}
