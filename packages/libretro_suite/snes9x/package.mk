PKG_NAME="snes9x"
PKG_VERSION="0655370"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/snes9x"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="Snes9x - Portable Super Nintendo Entertainment System (TM) emulator"
PKG_TOOLCHAIN="make"

make_target() {
  if [ "${ARCH}" = "arm" ]; then
    CXXFLAGS+=" -DARM"
  fi

  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    make -C libretro platform=classic_armv8_a35
  else
    make -C libretro
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/snes9x_libretro.so ${INSTALL}/usr/lib/libretro/
}
