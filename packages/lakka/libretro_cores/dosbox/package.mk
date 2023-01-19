PKG_NAME="dosbox"
PKG_VERSION="b7b24262c282c0caef2368c87323ff8c381b3102"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/dosbox-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro wrapper for the DOSBox emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

pre_make_target() {
  CXXFLAGS+=" -std=gnu++11"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v dosbox_libretro.so ${INSTALL}/usr/lib/libretro/
}
