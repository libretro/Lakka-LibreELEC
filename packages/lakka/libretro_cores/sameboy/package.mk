PKG_NAME="sameboy"
PKG_VERSION="8230189896a8bb6598574d302ba0ad3658f98ab4"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/LIJI32/SameBoy"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="libretro"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Gameboy and Gameboy Color emulator written in C"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="libretro"
PKG_BUILD_FLAGS="-parallel"

pre_make_target() {
  export BOOTROMS_DIR="${PKG_BUILD}/BootROMs/prebuilt"
}

makeinstall_target() {
  mkdir -p "${INSTALL}/usr/lib/libretro"
    cp -v "${PKG_BUILD}/build/bin/sameboy_libretro.so" "${INSTALL}/usr/lib/libretro/"
}
