PKG_NAME="lakka_update"
PKG_VERSION="0"
PKG_LICENSE="GPL"
PKG_LONGDESC="Shell script to wget the latest update"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
    cp -v lakka-update.sh ${INSTALL}/usr/bin/lakka-update
    chmod -v +x ${INSTALL}/usr/bin/lakka-update
}
