PKG_NAME="snes9x2002"
PKG_VERSION="540baad622d9833bba7e0696193cb06f5f02f564"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/snes9x2002"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Snes9x 2002. Port of SNES9x 1.39 for libretro (was previously called PocketSNES). Heavily optimized for ARM."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="platform=unix"

if [ "${PROJECT}" = "RPi" ] && [ "${DEVICE}" = "RPi" -o "${DEVICE}" = "GPICase" ]; then
  PKG_MAKE_OPTS_TARGET+=" ARM_ASM=1"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v snes9x2002_libretro.so ${INSTALL}/usr/lib/libretro/
}
