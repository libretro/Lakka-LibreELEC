PKG_NAME="jaxe"
PKG_VERSION="4825aad24716f67924cd949354aae490a14b4d2d"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/kurtjd/jaxe"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A fully-featured, cross platform XO-CHIP/S-CHIP/CHIP-8 emulator"
PKG_TOOLCHAIN="make"
PKG_MAKE_OPTS_TARGET="-f Makefile.libretro -C ../"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../jaxe_libretro.so ${INSTALL}/usr/lib/libretro/
}
