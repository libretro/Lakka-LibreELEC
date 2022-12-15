PKG_NAME="fuse_libretro"
PKG_VERSION="3f9344ddf88dfd251d95cffdea615692479e8cc6"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/fuse-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain bzip2"
PKG_LONGDESC="A port of the Fuse Unix Spectrum Emulator to libretro "
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

pre_make_target() {
  CFLAGS+=" -DHAVE_LIBBZ2"
  CXXFLAGS+=" -DHAVE_LIBBZ2"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v fuse_libretro.so ${INSTALL}/usr/lib/libretro/
}
