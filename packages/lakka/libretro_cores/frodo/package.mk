PKG_NAME="frodo"
PKG_VERSION="4c1501686ac0a6815d6dc410556029b6577fd7ec"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/r-type/frodo-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Frodo - The free portable C64 emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v frodo_libretro.so ${INSTALL}/usr/lib/libretro/
}
