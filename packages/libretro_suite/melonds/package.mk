PKG_NAME="melonds"
PKG_VERSION="8dcfc6f"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/melonds"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro_suite"
PKG_SHORTDESC="DS emulator, sorta"
PKG_TOOLCHAIN="make"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

make_target() {
  if [ "${DEVICE}" = "RPi4" -a "${ARCH}" = "aarch64" ]; then
    make -C ${PKG_BUILD} platform=rpi4_64
  elif [ "${OPENGL_SUPPORT}" = yes ]; then
    make -C ${PKG_BUILD} HAVE_OPENGL=1
  else
    make -C ${PKG_BUILD} HAVE_OPENGL=0
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp ${PKG_BUILD}/melonds_libretro.so ${INSTALL}/usr/lib/libretro/
}
