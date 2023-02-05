PKG_NAME="ep128emu"
PKG_VERSION="8db4a5b537fa2e511e85752129dbdcf7e4ee313c"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/ep128emu-core"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="core"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Enterprise 128 emulator for libretro"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ep128emu_core_libretro.so ${INSTALL}/usr/lib/libretro/
}
