PKG_NAME="rewritefs"
PKG_VERSION="33fb844d8e8ff441a3fc80d2715e8c64f8563d81"
PKG_ARCH="any"
PKG_SITE="https://github.com/sloonz/rewritefs"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain fuse pcre"
PKG_SECTION="tools"
PKG_SHORTDESC="A FUSE filesystem intended to be used like Apache mod_rewrite"
PKG_MAKE_OPTS_TARGET="PREFIX=/usr"
PKG_TOOLCHAIN="make"

pre_make_target() {
  export CFLAGS="${TARGET_CFLAGS}"
  export CPPFLAGS="${TARGET_CPPFLAGS}"
  export LDFLAGS="${TARGET_LDFLAGS}"
  export CROSS_COMPILE="${TARGET_PREFIX}"
}

makeinstall_target() {
  DESTDIR=${INSTALL}/usr make install
}

post_install() {
  mkdir -p ${INSTALL}/etc
    cp -v ${PKG_DIR}/configs/rewritefs.conf ${INSTALL}/etc/
}
