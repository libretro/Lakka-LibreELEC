PKG_NAME="rmtfs"
PKG_SITE="https://github.com/andersson/rmtfs"
PKG_LICENSE="Sony"
PKG_VERSION="b08ef6f98ec567876d7d45f15c85c6ed00d7c463"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="qrtr"
PKG_TOOLCHAIN="make"

post_install() {
  enable_service rmtfs.service
}
