PKG_NAME="bsnes_hd"
PKG_VERSION="65f24e5"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/DerKoun/bsnes-hd"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Fork of bsnes that adds HD video features."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_TOOLCHAIN="make"

make_target() {
 make -C bsnes -f GNUmakefile target="libretro" compiler="$CXX" CXXFLAGS="$CXXFLAGS" platform=linux local=false binary=library
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp bsnes/out/bsnes_hd_beta_libretro.so $INSTALL/usr/lib/libretro/
}
