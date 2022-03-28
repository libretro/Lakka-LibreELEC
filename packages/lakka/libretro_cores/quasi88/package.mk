PKG_NAME="quasi88"
PKG_VERSION="2548625ba2bc3b5a9ecae7db24fdd5d42570e578"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/libretro/quasi88-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A port of QUASI88, a PC-8800 series emulator by Showzoh Fukunaga, to the libretro API"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v quasi88_libretro.so ${INSTALL}/usr/lib/libretro/
}
