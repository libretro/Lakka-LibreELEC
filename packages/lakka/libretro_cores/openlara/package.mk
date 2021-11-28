PKG_NAME="openlara"
PKG_VERSION="fe88d74673344afc71891717b2474d33f90c165f"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/libretro/openlara"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Classic Tomb Raider open-source engine"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C src/platform/libretro/"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_MAKE_OPTS_TARGET+=" GLES=1"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

pre_make_target() {
  if [ "${OPENGLES}" = "bcm2835-driver" ]; then
    CFLAGS+=" -I${SYSROOT_PREFIX}/usr/include/interface/vcos/pthreads \
              -I${SYSROOT_PREFIX}/usr/include/interface/vmcs_host/linux"
    CXXFLAGS+=" -I${SYSROOT_PREFIX}/usr/include/interface/vcos/pthreads \
                -I${SYSROOT_PREFIX}/usr/include/interface/vmcs_host/linux"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v src/platform/libretro/*_libretro.so ${INSTALL}/usr/lib/libretro/
}
