PKG_NAME="superbroswar"
PKG_VERSION="f30808ba4d82ce17cc15af87a46c61920bd2806a"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/superbroswar-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Super Bros War deathmatch game."
PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v superbroswar_libretro.so ${INSTALL}/usr/lib/libretro/
}
