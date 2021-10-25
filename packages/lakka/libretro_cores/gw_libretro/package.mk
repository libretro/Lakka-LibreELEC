PKG_NAME="gw_libretro"
PKG_VERSION="0f1ccca"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/gw-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A libretro core for Game & Watch simulators"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v gw_libretro.so ${INSTALL}/usr/lib/libretro/
}
