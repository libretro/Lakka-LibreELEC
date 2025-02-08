PKG_NAME="pzretro"
PKG_VERSION="1f2aea81d39dc9dd598a83d4693fb88ea763239f"
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
