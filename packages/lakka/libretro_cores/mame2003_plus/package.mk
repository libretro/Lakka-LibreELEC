PKG_NAME="mame2003_plus"
PKG_VERSION="29ac9a30929f82f68424e10175e6b64e06136b27"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/mame2003-plus-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="MAME - Multiple Arcade Machine Emulator"
PKG_TOOLCHAIN="make"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET="ARCH= CC=${CC} NATIVE_CC=${CC} LD=${CC}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mame2003_plus_libretro.so ${INSTALL}/usr/lib/libretro/

  mkdir -p ${INSTALL}/usr/share/libretro-database/mame2003-plus
    cp -v metadata/mame2003-plus.xml ${INSTALL}/usr/share/libretro-database/mame2003-plus

  mkdir -p ${INSTALL}/usr/share/retroarch-system/mame2003-plus
    cp -r metadata/artwork ${INSTALL}/usr/share/retroarch-system/mame2003-plus
    cp metadata/cheat.dat ${INSTALL}/usr/share/retroarch-system/mame2003-plus
    cp metadata/history.dat ${INSTALL}/usr/share/retroarch-system/mame2003-plus
}
