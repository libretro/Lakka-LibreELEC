PKG_NAME="noods"
PKG_VERSION="aae9dc6e5ae0d9187e8dea4b74e529a8e9c8b1d3"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/jonian/libretro-noods"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Unofficial libretro port of the NooDS nds emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro platform=unix"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v noods_libretro.so ${INSTALL}/usr/lib/libretro/
}
