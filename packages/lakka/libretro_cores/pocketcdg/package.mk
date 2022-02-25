PKG_NAME="pocketcdg"
PKG_VERSION="c7b3aade99bc223ec6ba5eb9f93e0e6d1208de1a"
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
