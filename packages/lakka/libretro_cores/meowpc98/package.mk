PKG_NAME="meowpc98"
PKG_VERSION="bee2e243b0c68f787d0d360c2d4c289e581620ef"
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
