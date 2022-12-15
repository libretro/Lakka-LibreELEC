PKG_NAME="desmume"
PKG_VERSION="fbd368c8109f95650e1f81bca1facd6d4d8687d7"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/desmume"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain libpcap"
PKG_LONGDESC="libretro wrapper for desmume NDS emulator."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C desmume/src/frontend/libretro"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
  PKG_MAKE_OPTS_TARGET+=" HAVE_GL=1 DESMUME_OPENGL=1 DESMUME_OPENGL_CORE=1"
else
  PKG_MAKE_OPTS_TARGET+=" HAVE_GL=0 DESMUME_OPENGL=0 DESMUME_OPENGL_CORE=0"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

if [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=armv-unix"
elif [ "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=arm64-unix"
else
  PKG_MAKE_OPTS_TARGET+=" platform=unix"
fi


post_patch() {
  # enable OGL back if present
  if [ "${OPENGL_SUPPORT}" = yes ]; then
    patch --reverse -d $(echo "${PKG_BUILD}" | cut -f1 -d\ ) -p1 < ${PKG_DIR}/patches/desmume-002-disable-ogl.patch
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v desmume/src/frontend/libretro/desmume_libretro.so ${INSTALL}/usr/lib/libretro/
}
