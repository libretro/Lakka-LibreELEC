PKG_NAME="gw_libretro"
PKG_VERSION="435e5cfd4bf6aea03a84259e9b8dba3daf3ff5bd"
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
