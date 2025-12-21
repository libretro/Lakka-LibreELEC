PKG_NAME="core_info"
PKG_VERSION="20e7d555f911f5aa6712d5937f7b9b834015d88d"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/libretro-core-info"
PKG_URL="${PKG_SITE}.git"
PKG_LONGDESC="Info files for libretro cores"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  make -C ${PKG_BUILD} install INSTALLDIR="${INSTALL}/usr/lib/libretro"

  # ScummVM package provides own core info file
  rm -v ${INSTALL}/usr/lib/libretro/scummvm_libretro.info

  # mGBA core built from upstream repo - create a duplicate .info file
  cp -v ${INSTALL}/usr/lib/libretro/mgba_libretro.info \
        ${INSTALL}/usr/lib/libretro/mgba_fork_libretro.info
  sed -i ${INSTALL}/usr/lib/libretro/mgba_fork_libretro.info \
      -e "s|mGBA|mGBA-fork|g"
}
