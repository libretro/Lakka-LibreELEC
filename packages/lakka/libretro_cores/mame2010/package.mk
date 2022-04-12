PKG_NAME="mame2010"
PKG_VERSION="932e6f2c4f13b67b29ab33428a4037dee9a236a8"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/mame2010-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Late 2010 version of MAME (0.139) for libretro. Compatible with MAME 0.139 romsets."
PKG_TOOLCHAIN="manual"

make_target() {
  if [ "${ARCH}" = "arm" ]; then
    make CC=${CC} LD=${CC} PLATCFLAGS="${CFLAGS}" PTR64=0 ARM_ENABLED=1 LCPU=arm
  elif [ "${ARCH}" = "i386" ]; then
    make CC=${CC} LD=${CC} PLATCFLAGS="${CFLAGS}" PTR64=0 ARM_ENABLED=0 LCPU=x86
  elif [ "${ARCH}" = "x86_64" ]; then
    make CC=${CC} LD=${CC} PLATCFLAGS="${CFLAGS}" PTR64=1 ARM_ENABLED=0 LCPU=x86_64
  elif [ "${ARCH}" = "aarch64" ]; then
    make CC=${CC} LD=${CC} PLATCFLAGS="${CFLAGS}" PTR64=1 ARM_ENABLED=1 LCPU=arm64
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mame2010_libretro.so ${INSTALL}/usr/lib/libretro/
  mkdir -p ${INSTALL}/usr/share/libretro-database/mame2010
    cp -v metadata/mame2010.xml ${INSTALL}/usr/share/libretro-database/mame2010/
}
