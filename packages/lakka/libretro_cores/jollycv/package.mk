PKG_NAME="jollycv"
PKG_VERSION="86f8e8607e0e36f596b911c59b04e48052953756"
PKG_LICENSE="BSD-3-Clause"
PKG_SITE="https://github.com/libretro/jollycv"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Jolly Good ColecoVision, CreatiVision, and My Vision Emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/jollycv_libretro.so ${INSTALL}/usr/lib/libretro/
}
