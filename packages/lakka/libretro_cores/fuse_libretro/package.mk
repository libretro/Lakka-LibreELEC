PKG_NAME="fuse_libretro"
PKG_VERSION="23f7db522e1b9ad22a142e828d7c3631eb653142"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/fuse-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A port of the Fuse Unix Spectrum Emulator to libretro "
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v fuse_libretro.so ${INSTALL}/usr/lib/libretro/
}
