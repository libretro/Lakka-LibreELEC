PKG_NAME="pzretro"
PKG_VERSION="6d859b47092f585a7ec05804c1d51a1676a06531"
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
