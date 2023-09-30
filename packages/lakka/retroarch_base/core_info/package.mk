PKG_NAME="core_info"
PKG_VERSION="63fc405d19f64b6559fe6428e719756a7979e596"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-core-info"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Info files for libretro cores"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/lib/libretro"

  # ScummVM package provides own core info file
  rm -f ${INSTALL}/usr/lib/libretro/scummvm_libretro.info
}
