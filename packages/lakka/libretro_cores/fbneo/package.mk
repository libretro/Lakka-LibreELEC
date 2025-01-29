PKG_NAME="fbneo"
PKG_VERSION="ca3897908f3b0c161f0e6539f846dae1cd815a12"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/fbneo"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Final Burn Neo to Libretro"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C src/burner/libretro"

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" profile=performance"

  if target_has_feature neon ; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
  fi

  if [ "${PROJECT}" = "Rockchip" -a "${DEVICE}" = "OdroidGoAdvance" ]; then
    PKG_MAKE_OPTS_TARGET+=" USE_CYCLONE=1"
  fi

else
  PKG_MAKE_OPTS_TARGET+=" profile=accuracy"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v src/burner/libretro/fbneo_libretro.so ${INSTALL}/usr/lib/libretro/

  mkdir -p ${INSTALL}/usr/share/libretro-database/fbneo
    cp -vr dats/* ${INSTALL}/usr/share/libretro-database/fbneo

  mkdir -p ${INSTALL}/usr/share/retroarch/system/fbneo
    cp metadata/hiscore.dat ${INSTALL}/usr/share/retroarch/system/fbneo
}
