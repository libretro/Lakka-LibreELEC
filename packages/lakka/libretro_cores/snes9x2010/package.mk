PKG_NAME="snes9x2010"
PKG_VERSION="693c0dd2a3004a6332a076a08d14c78086f26bc1"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/snes9x2010"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_LONGDESC="Snes9x 2010. Port of Snes9x 1.52+ to Libretro (previously called SNES9x Next). Rewritten in C and several optimizations and speedhacks."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v snes9x2010_libretro.so ${INSTALL}/usr/lib/libretro/
}
