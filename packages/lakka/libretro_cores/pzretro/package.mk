PKG_NAME="pzretro"
PKG_VERSION="18b527180939775734a433fb8e96f7666c140416"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/nwhitehead/pzretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro core to play PuzzleScript games"
PKG_TOOLCHAIN="make"
PKG_MAKE_OPTS_TARGET="-C ../"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../puzzlescript_libretro.so ${INSTALL}/usr/lib/libretro/
}
