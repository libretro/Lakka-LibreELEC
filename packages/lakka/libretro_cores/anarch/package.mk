PKG_NAME="anarch"
PKG_VERSION="512e562efe683489b7438cd13476aa84a506c8a7"
PKG_LICENSE="CC0-1.0"
PKG_SITE="https://codeberg.org/iyzsong/anarch-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Anarch, the suckless FPS game, port to libretro."
PKG_TOOLCHAIN="cmake"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/.${TARGET_NAME}/anarch_libretro.so ${INSTALL}/usr/lib/libretro/
}
