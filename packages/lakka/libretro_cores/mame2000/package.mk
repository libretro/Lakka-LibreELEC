PKG_NAME="mame2000"
PKG_VERSION="cee538f9b28f00039f298cb3c2b588203f07d0be"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/mame2000-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="MAME - Multiple Arcade Machine Emulator"
PKG_TOOLCHAIN="make"

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET="ARM=1 USE_CYCLONE=1 USE_DRZ80=1"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mame2000_libretro.so ${INSTALL}/usr/lib/libretro/
}
