PKG_NAME="puae"
PKG_VERSION="f151bab41034b715628a2c62ce224fd0f581a132"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-uae"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Portable Commodore Amiga Emulator"
PKG_TOOLCHAIN="make"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v puae_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/retroarch-system/uae_data
    cp -vR ${PKG_BUILD}/sources/uae_data/* ${INSTALL}/usr/share/retroarch-system/uae_data/
}