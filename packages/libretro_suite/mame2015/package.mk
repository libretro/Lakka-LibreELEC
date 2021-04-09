PKG_NAME="mame2015"
PKG_VERSION="ef41361"
PKG_ARCH="x86_64 aarch64 arm"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2015-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_SHORTDESC="Late 2014/Early 2015 version of MAME (0.160-ish) for libretro and MAME 0.160 romsets"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET=""

if [ "${PROJECT}" != "Generic" ]; then
  case ${DEVICE:-$PROJECT} in
    RPi)
      PKG_MAKE_OPTS_TARGET+=" platform=armv6-hardfloat-arm1176jzf-s"
      ;;
    RPi2)
      PKG_MAKE_OPTS_TARGET+=" platform=armv7-neon-hardfloat-cortex-a7"
      ;;
    iMX6)
      PKG_MAKE_OPTS_TARGET+=" platform=armv7-neon-hardfloat-cortex-a9"
      ;;
    *)
      PKG_MAKE_OPTS_TARGET+=" platform=armv"
      ;;
  esac
fi

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" REALCC=${CC} CC=${CXX} LD=${CXX}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mame2015_libretro.so ${INSTALL}/usr/lib/libretro/
}
