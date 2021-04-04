PKG_NAME="empty"
PKG_VERSION="0.6.20b"
PKG_LICENSE="GPL"
PKG_DEPENDS_TARGET="toolchain"
PKG_SITE="http://empty.sourceforge.net/"
PKG_URL="http://downloads.sourceforge.net/sourceforge/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tgz"
PKG_SHORTDESC="Run applications under pseudo-terminal sessions"

make_target() {
  make CC=${CC}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  cp empty ${INSTALL}/usr/bin/
}
