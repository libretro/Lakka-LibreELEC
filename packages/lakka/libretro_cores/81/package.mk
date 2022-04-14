PKG_NAME="81"
PKG_VERSION="2e34567a320cba27b9162b1776db4de3cdb7cf03"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/81-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A port of the EightyOne ZX81 Emulator to libretro"
PKG_TOOLCHAIN="make"
PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v 81_libretro.so ${INSTALL}/usr/lib/libretro/
}
