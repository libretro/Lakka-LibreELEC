PKG_NAME="quicknes"
PKG_VERSION="dbf19f73e3eb9701d1c7f5898f57c097e05c9fbd"
PKG_LICENSE="LGPLv2.1+"
PKG_SITE="https://github.com/libretro/QuickNES_Core"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The QuickNES core library, originally by Shay Green, heavily modified"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v quicknes_libretro.so ${INSTALL}/usr/lib/libretro/
}
