PKG_NAME="race"
PKG_VERSION="b629dc887401a95b2f7799692496993c168de514"
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
