PKG_NAME="bsnes_hd"
PKG_VERSION="0bb7b8645e22ea2476cabd58f32e987b14686601"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/DerKoun/bsnes-hd"
PKG_URL="${PKG_SITE}.git"
PKG_BRANCH="master"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Fork of bsnes that adds HD video features."
PKG_TOOLCHAIN="make"

make_target() {
  make -C bsnes -f GNUmakefile target="libretro" compiler="${CXX}" CXXFLAGS="${CXXFLAGS}" platform=linux local=false binary=library
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v bsnes/out/bsnes_hd_beta_libretro.so ${INSTALL}/usr/lib/libretro/
}
