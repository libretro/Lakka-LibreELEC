PKG_NAME="lrps2"
PKG_VERSION="9485a53fa5aa2bff17e04518116107f81a8c82e3"
PKG_LICENSE="GPLv3"
PKG_ARCH="x86_64"
PKG_SITE="https://github.com/libretro/ps2"
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
  PKG_CMAKE_OPTS+=" -DUSE_OPENGL=ON"
fi

if [ "${VULKAN_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_CMAKE_OPTS+=" -DUSE_VULKAN=ON"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/.${TARGET_NAME}/bin/pcsx2_libretro.so ${INSTALL}/usr/lib/libretro/
}
