PKG_NAME="b2"
PKG_VERSION="9a00b26945a5945de8e2c36de9af47836b55bb79"
PKG_LICENSE="GPL-3.0"
PKG_SITE="https://github.com/zoltanvb/b2-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain util-linux"
PKG_LONGDESC="BBC Micro emulator for libretro"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../src/libretro"

pre_make_target() {
  if [ "${PROJECT}" != "L4T" ]; then
    CFLAGS+=" -DSYSTEM_HAVE_STRLCPY"
    CXXFLAGS+=" -DSYSTEM_HAVE_STRLCPY"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/src/libretro/b2_libretro.so ${INSTALL}/usr/lib/libretro/
}
