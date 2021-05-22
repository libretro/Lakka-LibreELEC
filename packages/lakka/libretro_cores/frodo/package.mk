PKG_NAME="frodo"
PKG_VERSION="4c15016"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/r-type/frodo-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Frodo - The free portable C64 emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v frodo_libretro.so ${INSTALL}/usr/lib/libretro/
}
