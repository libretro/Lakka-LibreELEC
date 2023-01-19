PKG_NAME="tic80"
PKG_VERSION="bd6ce86174fc7c9d7d3a86263acf3a7de1b62c11"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/TIC-80"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="TIC-80 is a fantasy computer for making, playing and sharing tiny games."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DBUILD_PLAYER=OFF \
                       -DBUILD_SDL=OFF \
                       -DBUILD_SOKOL=OFF \
                       -DBUILD_DEMO_CARTS=OFF \
                       -DBUILD_LIBRETRO=ON \
                       -DBUILD_WITH_MRUBY=OFF \
                       -DCMAKE_BUILD_TYPE=Release"

pre_configure_target() {
  PKG_CMAKE_SCRIPT="${PKG_BUILD}/core/CMakeLists.txt"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v lib/tic80_libretro.so ${INSTALL}/usr/lib/libretro/
}
