PKG_NAME="fuse_libretro"
PKG_VERSION="e52a9eb"
PKG_ARCH="i386 x86_64 arm"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/fuse-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="A port of the Fuse Unix Spectrum Emulator to libretro "
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v fuse_libretro.so ${INSTALL}/usr/lib/libretro/
}
