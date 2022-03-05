PKG_NAME="superbroswar"
PKG_VERSION="7d9876ea14ae743fa96d63207996e422131e0b68"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/superbroswar-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Super Bros War deathmatch game."

make_target() {
  make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v superbroswar_libretro.so ${INSTALL}/usr/lib/libretro/
}
