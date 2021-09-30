PKG_NAME="scummvm"
PKG_VERSION="519b5d3"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/scummvm"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ScummVM with libretro backend."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../backends/platform/libretro/build/"

pre_make_target() {
  CXXFLAGS+=" -DHAVE_POSIX_MEMALIGN=1"
  if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=oga_a35_neon_hardfloat"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../backends/platform/libretro/build/scummvm_libretro.so ${INSTALL}/usr/lib/libretro/
}
