PKG_NAME="snes9x2002"
PKG_VERSION="a0709ec7dcd6de2fbebb43106bd757b649e3b7cf"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/snes9x2002"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Snes9x 2002. Port of SNES9x 1.39 for libretro (was previously called PocketSNES). Heavily optimized for ARM."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="platform=unix"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v snes9x2002_libretro.so ${INSTALL}/usr/lib/libretro/
}
