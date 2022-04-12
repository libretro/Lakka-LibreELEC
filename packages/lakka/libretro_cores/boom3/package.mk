PKG_NAME="boom3"
PKG_VERSION="f271fa75b678eb4ff62a7f6e8945e94176d0d5f8"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/boom3"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Dhewm 3(Doom 3 Source Port) Libretro Core"
PKG_TOOLCHAIN="make"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

pre_make_target() {
  cd ${PKG_BUILD}/neo
}

make_target() {
  if [ "${PROJECT}" = "L4T" -a "${L4T_DEVICE_TYPE}" = "t210" ]; then
    make platform=tegra210
  else
    make
  fi
}


makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v boom3_libretro.so ${INSTALL}/usr/lib/libretro/
}
