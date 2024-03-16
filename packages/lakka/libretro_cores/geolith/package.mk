PKG_NAME="geolith"
PKG_VERSION="1ca863e1a10f40be3f3c4cccf22719c6a859d2b3"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/libretro/geolith-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Highly accurate emulator for the Neo Geo AES and MVS Cartridge Systems"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/geolith_libretro.so ${INSTALL}/usr/lib/libretro/
}

