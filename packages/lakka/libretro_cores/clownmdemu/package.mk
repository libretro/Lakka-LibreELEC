PKG_NAME="clownmdemu"
PKG_VERSION="c226c857335303d8974d9a22e7585b261606f478"
PKG_LICENSE="AGPLv3"
PKG_SITE="https://github.com/Clownacy/clownmdemu-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Frontend for ClownMDEmu that exposes it as a libretro core."
PKG_TOOLCHAIN="cmake"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v clownmdemu_libretro.so ${INSTALL}/usr/lib/libretro/
}
