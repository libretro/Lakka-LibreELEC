PKG_NAME="xbox360_controllers_shutdown"
PKG_VERSION="c0d560967c0a685f2863b7185fcc54d730390d08"
PKG_SHA256="a0c736ca448895260f90455decb99ef6c8ddb6bb65a2efbbaa4333e237868e69"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/spleen1981/xbox360-controllers-shutdown"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain glibc libusb"
PKG_LONGDESC="Small utility to turn off Xbox360 controllers in Linux "
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin/
    cp -v xbox360-controllers-shutdown ${INSTALL}/usr/bin/
}

post_install() {
  enable_service xbox360-controllers-shutdown.service
}
