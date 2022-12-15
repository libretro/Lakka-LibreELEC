PKG_NAME="parallel_n64"
PKG_VERSION="a03fdcba6b2e9993f050b50112f597ce2f44fa2c"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/parallel-n64"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Optimized/rewritten Nintendo 64 emulator made specifically for Libretro. Originally based on Mupen64 Plus."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="HAVE_PARALLEL=1"

if [ "${ARCH}" = "i386" ]; then
  PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=x86"
else
  PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=${ARCH}"
fi

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
else
  PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=0"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

if [ "${PROJECT}" = "Generic" ]; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_PARALLEL_RSP=1 HAVE_THR_AL=1"
fi

pre_make_target() {
  if [ "${ARCH}" = "arm" -o "${ARCH}" = "aarch64" ]; then
    CFLAGS+=" -DARM_FIX -fcommon"
  fi

  if target_has_feature neon ; then
    CFLAGS+=" -DGL_BGRA_EXT=0x80E1" # Fix build for platforms where GL_BGRA_EXT is not defined
    [ "${ARCH}" = "arm" ] && PKG_MAKE_OPTS_TARGET+=" platform=armv-neon" || true
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v parallel_n64_libretro.so ${INSTALL}/usr/lib/libretro/
}
