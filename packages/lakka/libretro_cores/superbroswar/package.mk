PKG_NAME="superbroswar"
PKG_VERSION="a8dda0cf701d7a96a3e743c962b727b5e08f4ff1"
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
