PKG_NAME="vice"
PKG_VERSION="407654a"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/vice-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Versatile Commodore 8-bit Emulator version 3.0"
PKG_TOOLCHAIN="manual"

make_target() {
  if [ "${ARCH}" = "arm" ]; then
    CFLAGS+=" -DARM -DALIGN_DWORD -mthumb-interwork -falign-functions=16 -marm"
  fi
  make EMUTYPE=x64
  make EMUTYPE=x128
  make EMUTYPE=xplus4
  make EMUTYPE=xvic
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v vice_*_libretro.so ${INSTALL}/usr/lib/libretro/
}
