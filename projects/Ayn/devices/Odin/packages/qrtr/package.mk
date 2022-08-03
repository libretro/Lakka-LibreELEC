PKG_NAME="qrtr"
PKG_SITE="https://github.com/andersson/qrtr"
PKG_LICENSE="Sony"
PKG_VERSION="9dc7a88548c27983e06465d3fbba2ba27d4bc050"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain glibc systemd"
PKG_TOOLCHAIN="make"

post_install() {
  enable_service qrtr-ns.service
}
