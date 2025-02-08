PKG_NAME="tamalibretro"
PKG_VERSION="ec83dc1a5ea8bdbcd02cee81779c6dbe0e996ed2"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/celerizer/tamalibretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="TamaLIB Tamagotchi P1 emulator implementation in the libretro API"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v tamalibretro_libretro.so ${INSTALL}/usr/lib/libretro/
}
