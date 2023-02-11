PKG_NAME="puae2021"
PKG_VERSION="f50f4f2ae506a22529a9935c4b45f375401021c9"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-uae"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="2.6.1"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Portable Commodore Amiga Emulator. Branch frozen at older version for better performance."
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v puae2021_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch/system/uae_data
    cp -vR ${PKG_BUILD}/sources/uae_data/* ${INSTALL}/usr/share/retroarch/system/uae_data/
}
