PKG_NAME="snes9x"
PKG_VERSION="1c97117fbfd5bd5d7e9a890759f82d0dbbb3ddc0"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/snes9x"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Snes9x - Portable Super Nintendo Entertainment System (TM) emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro/"

if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=classic_armv8_a35"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v libretro/snes9x_libretro.so ${INSTALL}/usr/lib/libretro/
}
