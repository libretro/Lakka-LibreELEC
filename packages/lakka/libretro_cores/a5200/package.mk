PKG_NAME="a5200"
PKG_VERSION="b8f8571eb5c6f484fe6be9a3a895ffb162b08422"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/a5200"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro port of Atari 5200 emulator version 2.0.2 for GCW0"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v a5200_libretro.so ${INSTALL}/usr/lib/libretro/
}
