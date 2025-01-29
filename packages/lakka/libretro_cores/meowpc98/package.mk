PKG_NAME="meowpc98"
PKG_VERSION="dc905d4e10470ff65a38e8b9e1a75b43b9b12149"
PKG_LICENSE="Unknown"
PKG_SITE="https://github.com/libretro/libretro-meowPC98"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Neko Project 2 (PC98 emulator) port for libretro/RetroArch"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro/ -f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/nekop2_libretro.so ${INSTALL}/usr/lib/libretro/
}
