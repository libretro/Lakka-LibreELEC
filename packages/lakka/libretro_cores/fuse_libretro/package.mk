PKG_NAME="fuse_libretro"
PKG_VERSION="8b734a975633a0ed21494c2e1a50e7e1de432122"
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
