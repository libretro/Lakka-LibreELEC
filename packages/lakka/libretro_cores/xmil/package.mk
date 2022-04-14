PKG_NAME="xmil"
PKG_VERSION="fc18430bdecae91d470d728a86e6fb3f85d029e6"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/libretro/xmil-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro port of X Millennium Sharp X1 emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro/ -f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/x1_libretro.so ${INSTALL}/usr/lib/libretro/
}
