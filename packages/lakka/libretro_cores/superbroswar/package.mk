PKG_NAME="superbroswar"
PKG_VERSION="91a029839868d8c4aec925ffc1b7bfc641ae1a8d"
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
