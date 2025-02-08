PKG_NAME="a5200"
PKG_VERSION="526404072821bb2021fab16f8c5dbbca300512c8"
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
