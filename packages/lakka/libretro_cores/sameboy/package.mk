PKG_NAME="sameboy"
PKG_VERSION="68f67b3db7747ba7aac84c5c253bc71d5a906525"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/sameboy"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Gameboy and Gameboy Color emulator written in C"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro/"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/sameboy_libretro.so ${INSTALL}/usr/lib/libretro/
}
