PKG_NAME="dirksimple"
PKG_VERSION="ce2581b47f0e8f0598d085f49140ce5bca5310c5"
PKG_LICENSE="Zlib"
PKG_SITE="https://github.com/icculus/DirkSimple"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Libretro core of dirt-simple Dragon's Lair player"
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v dirksimple_libretro.so ${INSTALL}/usr/lib/libretro/
    cp -v ../dirksimple_libretro.info ${INSTALL}/usr/lib/libretro/

  mkdir -p ${INSTALL}/usr/share/retroarch/system/DirkSimple
    cp -vr ../games ${INSTALL}/usr/share/retroarch/system/DirkSimple
}
