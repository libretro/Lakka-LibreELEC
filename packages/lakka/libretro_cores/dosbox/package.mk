PKG_NAME="dosbox"
PKG_VERSION="aa71b67d54eaaf9e41cdd3cb5153d9cff0ad116e"
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
