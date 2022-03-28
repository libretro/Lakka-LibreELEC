PKG_NAME="dosbox"
PKG_VERSION="1aff406faed3cfde5c1b658bacd9f8f639915912"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/dosbox-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro wrapper for the DOSBox emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v dosbox_libretro.so ${INSTALL}/usr/lib/libretro/
}
