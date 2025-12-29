PKG_NAME="upFS"
PKG_VERSION="9a906da00d97d9b31fae91a431031d55ed99571c"
PKG_ARCH="any"
PKG_SITE="https://github.com/GregorR/upfs"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_INIT="toolchain fuse fuse:init"
PKG_DEPENDS_TARGET="toolchain fuse"
PKG_SECTION="tools"
PKG_SHORTDESC="A FUSE filesystem intended to be used like UMSDOS"
PKG_MAKE_OPTS_TARGET="PREFIX=/usr"
PKG_TOOLCHAIN="make"

#Set Compiler Flags
export CFLAGS="${TARGET_CFLAGS}"
export CPPFLAGS="${TARGET_CPPFLAGS}"
export LDFLAGS="${TARGET_LDFLAGS}"
export CROSS_COMPILE="${TARGET_PREFIX}"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/sbin
  DESTDIR=${INSTALL} make install
}

makeinstall_init() {
  mkdir -p ${INSTALL}/usr/bin
  mkdir -p ${INSTALL}/sbin
  DESTDIR=${INSTALL} make install
  mv ${INSTALL}/sbin ${INSTALL}/usr/sbin
}
