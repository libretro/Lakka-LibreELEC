PKG_NAME="fbalpha2012"
PKG_VERSION="77167cea72e808384c136c8c163a6b4975ce7a84"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/fbalpha2012"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Port of Final Burn Alpha 2012 to Libretro"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f makefile.libretro \
                      -C svn-current/trunk"

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=armv"
fi

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" CC=${CC} CXX=${CXX}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v svn-current/trunk/fbalpha2012_libretro.so ${INSTALL}/usr/lib/libretro/
}
