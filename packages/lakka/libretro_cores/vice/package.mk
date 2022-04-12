PKG_NAME="vice"
PKG_VERSION="af8368a1ab10870486cc35586cf31bb72dfa9a30"
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
