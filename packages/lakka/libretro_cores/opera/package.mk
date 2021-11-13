PKG_NAME="opera"
PKG_VERSION="d8aa7cecf96298bd7ee51718086f7b1bc8c57e2a"
PKG_LICENSE="LGPL with additional notes"
PKG_SITE="https://github.com/libretro/opera-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of 4DO/libfreedo to libretro."
PKG_TOOLCHAIN="make"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET="CC=${CC} CXX=${CXX} AR=${AR}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v opera_libretro.so ${INSTALL}/usr/lib/libretro/
}
