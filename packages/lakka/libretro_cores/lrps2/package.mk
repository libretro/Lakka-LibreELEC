PKG_NAME="lrps2"
PKG_VERSION="8d14ef94c95b194fbfe0d7d82054a32ab21368fe"
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
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_OPENGL=ON"
fi

if [ "${VULKAN_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_CMAKE_OPTS_TARGET+=" -DUSE_VULKAN=ON"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/.${TARGET_NAME}/bin/pcsx2_libretro.so ${INSTALL}/usr/lib/libretro/

  # copy per-game hacks database
  mkdir -p ${INSTALL}/usr/share/retroarch/system/pcsx2/resources
    cp -rv ${PKG_BUILD}/bin/resources/GameIndex.yaml ${INSTALL}/usr/share/retroarch/system/pcsx2/resources
}
