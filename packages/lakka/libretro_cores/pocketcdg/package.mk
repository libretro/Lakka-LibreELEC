PKG_NAME="pocketcdg"
PKG_VERSION="afb88fb20b39e548b8a95791839f59b111892f21"
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
