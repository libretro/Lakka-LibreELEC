PKG_NAME="pokemini"
PKG_VERSION="b24883d9bddaa3ee32f06a6f2e361581414dc155"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/pokemini"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Obscure nintendo handheld emulator (functional,no color files or savestates currently)"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v pokemini_libretro.so ${INSTALL}/usr/lib/libretro/
}
