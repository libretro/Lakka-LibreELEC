PKG_NAME="lrps2"
PKG_VERSION="797ed4f60841b09ecfad28ab01203182cb5a98cb"
PKG_LICENSE="GPLv3"
PKG_ARCH="x86_64 aarch64"
PKG_SITE="https://github.com/libretro/parallel-ps2"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="PS2 emulator"
PKG_TOOLCHAIN="cmake"

if [ "${OPENGL_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${OPENGL_SUPPORT}" = yes -o "${OPENGLES_SUPPORT}" = yes ]; then
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_OPENGL=ON"
fi

if [ "${VULKAN_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN=ON"
fi

if [ "${ARCH}" = "aarch64" ]; then
  # Only the Vulkan renderer is supported on aarch64.
  PKG_CMAKE_OPTS_TARGET="${PKG_CMAKE_OPTS_TARGET//-DUSE_OPENGL=ON/-DUSE_OPENGL=OFF}"
fi

# RPi5 runs a 16K page kernel; the core's host page size must match it (see patches/).
pre_configure_target() {
  if [ "${DEVICE:0:4}" = "RPi5" ]; then
    export CFLAGS+=" -DPCSX2_HOST_PAGE_16K"
    export CXXFLAGS+=" -DPCSX2_HOST_PAGE_16K"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/.${TARGET_NAME}/bin/pcsx2_libretro.so ${INSTALL}/usr/lib/libretro/
}
