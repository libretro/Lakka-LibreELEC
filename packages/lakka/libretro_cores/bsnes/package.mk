PKG_NAME="bsnes"
PKG_VERSION="591b7e13b6914beffaa01084e4c0b7a5d9cc0673"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/bsnes"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Super Nintendo (Super Famicom) emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C bsnes -f GNUmakefile target=libretro platform=linux local=false"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" compiler=${CXX}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v bsnes/out/bsnes_libretro.so ${INSTALL}/usr/lib/libretro/
}
