PKG_NAME="libxmp-lite"
PKG_VERSION="4.4.1"
PKG_SHA256="bce9cbdaa19234e08e62660c19ed9a190134262066e7f8c323ea8ad2ac20dc39"
PKG_LICENSE="LGPL2"
PKG_SITE="http://sourceforge.net/projects/xmp"
PKG_URL="${PKG_SITE}/files/libxmp/${PKG_VERSION}/libxmp-lite-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libxmp is a library that renders module files to PCM data."

PKG_TOOLCHAIN="configure"

pre_configure_target() {
  cd ${PKG_BUILD}
}
