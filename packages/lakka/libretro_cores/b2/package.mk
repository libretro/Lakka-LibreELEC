PKG_NAME="b2"
PKG_VERSION="b16e3a4a91fed4d6d2ccb227211119da7b39c8d1"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://github.com/zoltanvb/b2-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain util-linux"
PKG_LONGDESC="BBC Micro emulator for libretro"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../src/libretro"

pre_make_target() {
  CFLAGS+=" -DSYSTEM_HAVE_STRLCPY"
  CXXFLAGS+=" -DSYSTEM_HAVE_STRLCPY"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/src/libretro/b2_libretro.so ${INSTALL}/usr/lib/libretro/
}
