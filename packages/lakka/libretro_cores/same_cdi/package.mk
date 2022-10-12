PKG_NAME="same_cdi"
PKG_VERSION="f8623c4a40994ada376244feabaeeaaed95fe458"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/same_cdi"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain expat zlib flac sqlite"
PKG_LONGDESC="SAME_CDI is a libretro core to play CD-i games. This is a fork and modification of the MAME libretro core"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro REGENIE=1 VERBOSE=1 NOWERROR=1 OPENMP=0 CROSS_BUILD=1 TOOLS=0 RETRO=1 \
PYTHON_EXECUTABLE=${TOOLCHAIN}/bin/${PKG_PYTHON_VERSION} CONFIG=libretro LIBRETRO_OS=unix TARGET=mame OSD=retro \
USE_SYSTEM_LIB_EXPAT=1 USE_SYSTEM_LIB_ZLIB=1 USE_SYSTEM_LIB_FLAC=1 USE_SYSTEM_LIB_SQLITE3=1 LIBRETRO_CPU= ARCH= PROJECT="

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
  [ "${ARCH}" = "aarch64" ] && export ARCHOPTS="-D__aarch64__ -DASMJIT_BUILD_X86"
  make ${PKG_MAKE_OPTS_TARGET}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v same_cdi_libretro.so ${INSTALL}/usr/lib/libretro/
}
