PKG_NAME="pocketcdg"
PKG_VERSION="1559b4e309888690722a86b897582f62dd598810"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-pocketcdg"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Karaoke player"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v pocketcdg_libretro.so ${INSTALL}/usr/lib/libretro/
}
