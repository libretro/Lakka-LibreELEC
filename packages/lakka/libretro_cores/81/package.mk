PKG_NAME="81"
PKG_VERSION="ffc99f27f092addc9ddd34dd0e3a3d4d1c053cbf"
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
