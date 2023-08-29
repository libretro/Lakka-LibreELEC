PKG_NAME="lutro"
PKG_VERSION="09a134eccad87127ec757503f736d6e4f9d06d4c"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-lutro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="An experimental lua game framework for libretro inspired by LÖVE"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="HAVE_COMPOSITION=1"

if target_has_feature neon; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
fi

if [ "${ARCH}" = "x86_64" -o "${ARCH}" = "aarm64" ]; then
  PKG_MAKE_OPTS_TARGET+=" PTR_SIZE=-m64"
else
  PKG_MAKE_OPTS_TARGET+=" PTR_SIZE=-m32"
fi

pre_make_target() {
  PKG_MAKE_OPTS_TARGET+=" HOST_CC=${HOST_CC} CROSS=${TARGET_PREFIX}"
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v lutro_libretro.so ${INSTALL}/usr/lib/libretro/
}
