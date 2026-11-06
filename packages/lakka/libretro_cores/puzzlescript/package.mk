PKG_NAME="puzzlescript"
PKG_VERSION="3e1a7aceae449760c8188bc9a7357da0c31b3202"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-puzzlescript"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro core to play PuzzleScript games"
PKG_TOOLCHAIN="make"
PKG_MAKE_OPTS_TARGET="-C ../"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../puzzlescript_libretro.so ${INSTALL}/usr/lib/libretro/
}
