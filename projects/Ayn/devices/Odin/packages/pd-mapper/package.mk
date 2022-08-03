PKG_NAME="pd-mapper"
PKG_SITE="https://github.com/andersson/pd-mapper"
PKG_LICENSE="Sony"
PKG_VERSION="9d78fc0c6143c4d1b7198c57be72a6699ce764c4"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="qrtr"
PKG_TOOLCHAIN="make"

post_install() {
  enable_service pd-mapper.service
}
