PKG_NAME="mame"
PKG_VERSION="1f6e6075e9668f55d93c5ef4fa3b032c00c0b305"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/mame"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="MAME - Multiple Arcade Machine Emulator"
#PKG_BUILD_FLAGS="-gold -lto"
PKG_TOOLCHAIN="manual"

make_target() {
  LCPU=${ARCH}
  PTR64=0
  NOASM=0

  if [ "${ARCH}" = "arm" ]; then
    NOASM=1
  elif [ "${ARCH}" = "i386" ]; then
    LCPU=x86
  elif [ "${ARCH}" = "x86_64" ]; then
    PTR64=1
  fi

  make REGENIE=1 VERBOSE=1 NOWERROR=1 PYTHON_EXECUTABLE=python2 CONFIG=libretro LIBRETRO_OS="unix" ARCH="" PROJECT="" LIBRETRO_CPU="${LCPU}" DISTRO="debian-stable" CC="${CC}" CXX="${CXX}" LD="${LD}" CROSS_BUILD="" PTR64="${PTR64}" TARGET="mame" SUBTARGET="arcade" PLATFORM=${LCPU} RETRO=1 OSD="retro"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v *_libretro.so ${INSTALL}/usr/lib/libretro/mame_libretro.so
}
