PKG_NAME="np2kai"
PKG_VERSION="2b09ea6a589cdcae27bca27160b3f82638fbb45d"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/AZO234/NP2kai"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_LONGDESC="Neko Project II kai (PC98 emulator)"
PKG_TOOLCHAIN="make"
PKG_MAKE_OPTS_TARGET="-C sdl -f Makefile.libretro NP2KAI_VERSION=rev.15"

pre_make_target() {
  cd "${PKG_BUILD}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v sdl/np2kai_libretro.so ${INSTALL}/usr/lib/libretro/
}
