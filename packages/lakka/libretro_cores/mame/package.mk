PKG_NAME="mame"
PKG_VERSION="5526dd0fbf6d312a12261643915b9f489ef7510b"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/mame"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain expat zlib flac sqlite"
PKG_LONGDESC="MAME - Multiple Arcade Machine Emulator"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro REGENIE=1 VERBOSE=1 NOWERROR=1 OPENMP=0 CROSS_BUILD=1 TOOLS=0 RETRO=1 PYTHON_EXECUTABLE=python3 CONFIG=libretro LIBRETRO_OS=unix TARGET=mame OSD=retro USE_SYSTEM_LIB_EXPAT=1 USE_SYSTEM_LIB_ZLIB=1 USE_SYSTEM_LIB_FLAC=1 USE_SYSTEM_LIB_SQLITE3=1 LIBRETRO_CPU= ARCH= PROJECT="

case ${ARCH} in
  x86_64)
    PKG_MAKE_OPTS_TARGET+=" NOASM=0 PTR64=1 PLATFORM=x86_64"
    ;;
  i386)
    PKG_MAKE_OPTS_TARGET+=" NOASM=0 PTR64=0 PLATFORM=x86"
    ;;
  aarch64)
    PKG_MAKE_OPTS_TARGET+=" NOASM=0 PTR64=0 PLATFORM=arm64"
    ;;
  arm)
    PKG_MAKE_OPTS_TARGET+=" NOASM=1 PTR64=0 PLATFORM=arm"
    ;;
esac

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" OVERRIDE_CC=${CC} OVERRIDE_CXX=${CXX} OVERRIDE_LD=${LD}"
  sed -i scripts/genie.lua \
      -e 's|-static-libstdc++||g'
}

make_target() {
  unset DISTRO
  make ${PKG_MAKE_OPTS_TARGET}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v mame_libretro.so ${INSTALL}/usr/lib/libretro/

  mkdir -p ${INSTALL}/usr/share/retroarch/system/mame
    cp -vr artwork samples ${INSTALL}/usr/share/retroarch/system/mame
}
