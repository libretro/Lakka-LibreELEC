PKG_NAME="wiringPi"
PKG_VERSION="b1dfc18"
PKG_LICENSE="LGPLv3"
PKG_SITE="http://wiringpi.com/"
PKG_URL="${LAKKA_MIRROR}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="GPIO Interface library for the Raspberry Pi"
PKG_TOOLCHAIN="manual"

make_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/
  mkdir -p ${SYSROOT_PREFIX}/usr/include/
  mkdir -p ${INSTALL}/usr/lib/

  cp wiringPi/*.h ${SYSROOT_PREFIX}/usr/include/
  make -C wiringPi CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" V=1 static
}

makeinstall_target() {
  cp -v wiringPi/libwiringPi.a* ${INSTALL}/usr/lib/
  cp -v wiringPi/libwiringPi.a* ${SYSROOT_PREFIX}/usr/lib/
}
