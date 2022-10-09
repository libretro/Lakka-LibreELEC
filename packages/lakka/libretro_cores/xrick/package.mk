PKG_NAME="xrick"
PKG_VERSION="7ee449e12062ea8d7ca0c945c3a4b63ca0c04268"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/xrick-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Rick Dangerous Game Engine"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" CC=${CC}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v xrick_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch/system/xrick
    cp -v data.zip ${INSTALL}/usr/share/retroarch/system/xrick
}
