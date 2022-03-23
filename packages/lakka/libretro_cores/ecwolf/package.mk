PKG_NAME="ecwolf"
PKG_VERSION="b1bbd64ed9d495c6d532db318d05aff658d2c731"
PKG_LICENSE="Unknown"
PKG_SITE="https://github.com/libretro/ecwolf"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SHORTDESC="ECWolf is a port of the Wolfenstein 3D engine based of Wolf4SDL."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C src/libretro"

pre_make_target() {
  cd ${PKG_BUILD}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp src/libretro/ecwolf_libretro.so ${INSTALL}/usr/lib/libretro/

  if [ -z "$(which 7z 2>/dev/null)" ]; then
    echo "************************************************************"
    echo "*       !!! !!! !!! !!!   WARNING     !!! !!! !!! !!!      *"
    echo "* No 7z archiver found on system, not packaging ecwolf.pk3 *"
    echo "************************************************************"
  else
    echo "Packaging ecwolf.pk3..."
    mkdir -p ${INSTALL}/usr/share/retroarch-system
      7z a -mx9 -tzip ${INSTALL}/usr/share/retroarch-system/ecwolf.pk3 "${PKG_BUILD}/wadsrc/static/"* >/dev/null
  fi
}
