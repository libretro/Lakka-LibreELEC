PKG_NAME="mame2015"
PKG_VERSION="2599c8aeaf84f62fe16ea00daa460a19298c121c"
PKG_ARCH="x86_64 aarch64 arm"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2015-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Late 2014/Early 2015 version of MAME (0.160-ish) for libretro and MAME 0.160 romsets"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET=""

if [ "${ARCH}" = "arm" ]; then
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
  make ${PKG_MAKE_OPTS_TARGET} maketree
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mame2015_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/libretro-database/mame201{4,5}
    unzip metadata/mame2014-xml.zip -d ${INSTALL}/usr/share/libretro-database/mame2014
    unzip metadata/mame2015-xml.zip -d ${INSTALL}/usr/share/libretro-database/mame2015
}
