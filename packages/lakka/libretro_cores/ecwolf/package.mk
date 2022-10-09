PKG_NAME="ecwolf"
PKG_VERSION="f098da0d003c4780adf6a9503801081f1f25cc27"
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
  mkdir -p ${INSTALL}/usr/share/retroarch/system
    echo "Packaging ecwolf.pk3..."
    7z a -mx9 -tzip ${INSTALL}/usr/share/retroarch/system/ecwolf.pk3 "${PKG_BUILD}/wadsrc/static/"* >/dev/null
}
