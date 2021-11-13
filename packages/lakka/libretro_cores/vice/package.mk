PKG_NAME="vice"
PKG_VERSION="c2b8877209ea6cb982b17b4bb5d329d65044e21b"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vice-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Versatile Commodore 8-bit Emulator version"
PKG_TOOLCHAIN="manual"

make_target() {
  for LRCORE in x64 x128 xplus4 xvic ; do
    make EMUTYPE=${LRCORE}
    make objectclean
  done
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v vice_*_libretro.so ${INSTALL}/usr/lib/libretro/
}
