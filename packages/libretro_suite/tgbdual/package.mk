PKG_NAME="tgbdual"
PKG_VERSION="fb6d2f6"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/tgbdual-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="libretro port of TGB Dual"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v tgbdual_libretro.so ${INSTALL}/usr/lib/libretro/
}
