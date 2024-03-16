PKG_NAME="core_info"
PKG_VERSION="8013cd3c6f9d09a6f9d81d97cb4e11f6e78fd369"
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
