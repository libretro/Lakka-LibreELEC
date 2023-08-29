PKG_NAME="gme"
PKG_VERSION="40d8b3bf4f0bd4f713f65e08c62d30b1ae8b2282"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-gme"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of blargg's Game_Music_Emu library."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v gme_libretro.so ${INSTALL}/usr/lib/libretro/
}

