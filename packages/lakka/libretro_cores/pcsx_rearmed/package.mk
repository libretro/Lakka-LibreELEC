PKG_NAME="pcsx_rearmed"
PKG_VERSION="589bd99ba31de8216624dbf0cbbc016f0663ce3d"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="ARM optimized PCSX fork"
PKG_BUILD_FLAGS="-gold"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-f Makefile.libretro -C ../"

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
fi

if [ "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=unix"
elif [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" DYNAREC=ari64"
  if target_has_feature neon ; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1 BUILTIN_GPU=neon"
  else
    PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=0 BUILTIN_GPU=unai"
  fi
fi

if [ "${DEVICE}" = "OdroidGoAdvance" ]; then
  sed -e "s|armv8-a|armv8-a+crc|" \
      -i ../Makefile.libretro
  PKG_MAKE_OPTS_TARGET+=" platfrom=classic_armv8_a35"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../pcsx_rearmed_libretro.so ${INSTALL}/usr/lib/libretro/
}
