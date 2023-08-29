PKG_NAME="race"
PKG_VERSION="f65011e6639ccbbbb44b6ffa63ca50c070475df4"
PKG_LICENSE="GPL2"
PKG_SITE="https://github.com/libretro/RACE"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="NeoGeo Pocket emulator"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v race_libretro.so ${INSTALL}/usr/lib/libretro/
}
