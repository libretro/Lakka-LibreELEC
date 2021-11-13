PKG_NAME="ecwolf"
PKG_VERSION="30c4192b63a2ab5d797616052c186413e8768e73"
PKG_LICENSE="Unknown"
PKG_SITE="https://github.com/libretro/ecwolf"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="ECWolf is a port of the Wolfenstein 3D engine based of Wolf4SDL."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C src/libretro"

pre_make_target() {
  cd ${PKG_BUILD}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp src/libretro/ecwolf_libretro.so ${INSTALL}/usr/lib/libretro/
}
