PKG_NAME="sameboy"
PKG_VERSION="51433012a871a44555492273fd22f29867d12655"
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
