PKG_NAME="higan_sfc"
PKG_VERSION="d3f592013a27cb78f17d84f90a6be6cf6f6af1d1"
PKG_LICENSE="GPLv3"
PKG_SITE="https://gitlab.com/higan/higan"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="libretro"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="higan, the multi-system emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f GNUmakefile \
                      -C higan/ \
                      target=libretro \
                      binary=library"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" compiler=${CXX}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v higan/out/higan_sfc_libretro.so ${INSTALL}/usr/lib/libretro/
}
