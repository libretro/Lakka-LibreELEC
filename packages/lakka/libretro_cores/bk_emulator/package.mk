PKG_NAME="bk_emulator"
PKG_VERSION="50a6a6e9b542da25f2d1bdf37f6f53b97929e141"
PKG_LICENSE="Opensource"
PKG_SITE="https://github.com/libretro/bk-emulator"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC=""
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v bk_libretro.so ${INSTALL}/usr/lib/libretro/
}
