PKG_NAME="dosbox_pure"
PKG_VERSION="d22a43d80a4dd17d64bcbd3977c85d06ac2c0dfe"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/dosbox-pure"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="DOSBox Pure is a fork of DOSBox, an emulator for DOS games, built for RetroArch/Libretro aiming for simplicity and ease of use."
PKG_TOOLCHAIN="make"

make_target() {
  # remove optimization from CFLAGS, set via Makefile
  CFLAGS="${CFLAGS//-O3/}"
  CFLAGS="${CFLAGS//-O2/}"
  make CXX=${CXX} CPUFLAGS="${CFLAGS}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v dosbox_pure_libretro.so ${INSTALL}/usr/lib/libretro/
}
