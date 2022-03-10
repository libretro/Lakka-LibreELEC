PKG_NAME="lr_moonlight"
PKG_VERSION="20d2d77d219613a2809fa9afe9606f6cf3be2aa0"
PKG_ARCH="aarch64 arm x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/rock88/moonlight-libretro"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain ffmpeg opus cairo curl"
PKG_LONGDESC="Moonlight-libretro is a port of Moonlight Game Streaming Project for RetroArch platform."

if [ "${PROJECT}" = "L4T" -a "${DEVICE}" = "Switch" ]; then
  PKG_MAKE_OPTS_TARGET="platform=lakka-switch TOOLCHAIN=${TOOLCHAIN}"
fi

if [ "${OPENGL_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGL}"
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v moonlight_libretro.so ${INSTALL}/usr/lib/libretro/
    cp -v ${PKG_DIR}/assets/moonlight_libretro.info ${INSTALL}/usr/lib/libretro/
}
