PKG_NAME="dosbox-pure"
PKG_VERSION="d22a43d"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/dosbox-pure"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_LONGDESC="DOSBox Pure is a fork of DOSBox, an emulator for DOS games, built for RetroArch/Libretro aiming for simplicity and ease of use."
PKG_BUILD_FLAGS="-lto"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make -f Makefile
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp dosbox_pure_libretro.so $INSTALL/usr/lib/libretro/
}
