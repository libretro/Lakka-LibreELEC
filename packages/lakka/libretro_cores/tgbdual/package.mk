PKG_NAME="tgbdual"
PKG_VERSION="8d305769eebd67266c284558f9d3a30498894d3d"
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
