PKG_NAME="fbneo"
PKG_VERSION="c68d212443c8fef7cea79b1548c64d18baed0ff5"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/fbneo"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain linux glibc"
PKG_LONGDESC="Port of Final Burn Neo to Libretro"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C src/burner/libretro"

pre_configure_target() {

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

  if [ "${TARGET_ARCH}" = "arm" ]; then
    export CFLAGS=$(echo ${CFLAGS} | sed -e "s|-D_FILE_OFFSET_BITS=64||g")
    export CFLAGS=$(echo ${CFLAGS} | sed -e "s|-D_TIME_BITS=64||g")
    export CXXFLAGS=$(echo ${CXXFLAGS} | sed -e "s|-D_FILE_OFFSET_BITS=64||g")
    export CXXFLAGS=$(echo ${CXXFLAGS} | sed -e "s|-D_TIME_BITS=64||g")
  fi
 }


makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v src/burner/libretro/fbneo_libretro.so ${INSTALL}/usr/lib/libretro/

  mkdir -p ${INSTALL}/usr/share/libretro-database/fbneo
    cp -vr dats/* ${INSTALL}/usr/share/libretro-database/fbneo

  mkdir -p ${INSTALL}/usr/share/retroarch/system/fbneo
    cp metadata/hiscore.dat ${INSTALL}/usr/share/retroarch/system/fbneo
}
