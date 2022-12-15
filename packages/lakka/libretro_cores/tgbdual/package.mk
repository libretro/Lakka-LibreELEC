PKG_NAME="tgbdual"
PKG_VERSION="a6f3018e6a23030afc1873845ee54d4b2d8ec9d3"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/tgbdual-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro port of TGB Dual"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v tgbdual_libretro.so ${INSTALL}/usr/lib/libretro/
}
