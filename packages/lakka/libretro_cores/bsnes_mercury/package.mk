PKG_NAME="bsnes_mercury"
PKG_VERSION="d232c6ea90552f5921fec33a06626f08d3e18b24"
PKG_ARCH="x86_64 i386"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/bsnes-mercury"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Fork of bsnes with HLE DSP emulation restored."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="ui=target-libretro profile=balanced"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" compiler=${CXX}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v bsnes_mercury_performance_libretro.so ${INSTALL}/usr/lib/libretro/
}