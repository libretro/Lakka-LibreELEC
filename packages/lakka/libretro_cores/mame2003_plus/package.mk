PKG_NAME="mame2003_plus"
PKG_VERSION="e28af780b8ebecf8fb31f5737dbefa4e41744f86"
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

  mkdir -p ${INSTALL}/usr/share/retroarch/system/mame2003-plus/samples
    cp -rv metadata/artwork ${INSTALL}/usr/share/retroarch/system/mame2003-plus
    cp -v metadata/{cheat,hiscore,history}.dat ${INSTALL}/usr/share/retroarch/system/mame2003-plus
    # something must be in a folder in order to include it in the image, so why not some instructions
    echo "Put your samples here." > ${INSTALL}/usr/share/retroarch/system/mame2003-plus/samples/readme.txt
}
