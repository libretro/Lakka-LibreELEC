PKG_NAME="higan_sfc_balanced"
PKG_VERSION="5e965d0db4c0d05e7e8fb6449035538781c73473"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/nSide"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A fork of higan v106 by byuu, which was renamed to exclude 'higan' at byuu's request."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f GNUmakefile \
                      -C nSide \
                      target=libretro \
                      binary=library"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" compiler=${CXX}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v nSide/out/higan_sfc_balanced_libretro.so ${INSTALL}/usr/lib/libretro/
}
