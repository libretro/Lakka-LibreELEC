PKG_NAME="tqftpserv"
PKG_SITE="https://github.com/andersson/tqftpserv"
PKG_LICENSE="Sony"
PKG_VERSION="783425b550de2a359db6aa3b41577c3fbaae5903"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="qrtr"
PKG_TOOLCHAIN="make"

post_install() {
  enable_service tqftpserv.service
}
