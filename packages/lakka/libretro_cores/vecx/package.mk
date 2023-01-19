PKG_NAME="vecx"
PKG_VERSION="33a8a89e92dbcef047a12e2c02dd55878be02a8f"
PKG_LICENSE="GPLv2|LGPLv2.1"
PKG_SITE="https://github.com/libretro/libretro-vecx"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="libretro adaptation of vecx"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

if [ "${PROJECT}" = "RPi" ]; then
  if [ "${OPENGLES}" = "mesa" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=rpi-mesa"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=rpi"
  fi
elif [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_MAKE_OPTS_TARGET+=" HAS_GLES=1 GLES=1"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v vecx_libretro.so ${INSTALL}/usr/lib/libretro/
}
