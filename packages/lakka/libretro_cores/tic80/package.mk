PKG_NAME="tic80"
PKG_VERSION="ade10badac181c0a9c32b38c6d66705ab9b2f2c9"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/nesbox/TIC-80"
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
  PKG_CMAKE_SCRIPT="${PKG_BUILD}/CMakeLists.txt"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v lib/tic80_libretro.so ${INSTALL}/usr/lib/libretro/
}
