PKG_NAME="dosbox_core"
PKG_VERSION="4032f8ba364e8594fd8e160121f6b13f6ee2bf65"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/realnc/dosbox-core"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="libretro"
PKG_DEPENDS_TARGET="toolchain SDL_net libvorbis flac libsndfile opusfile mpg123"
PKG_LONGDESC="A DOSBox core for use in RetroArch and other libretro frontends"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro BUNDLED_SDL=0 BUNDLED_AUDIO_CODECS=0 BUNDLED_LIBSNDFILE=0"

if [ "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=arm64"
elif [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=arm"
elif [ "${ARCH}" = "x86_64" ]; then
  PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=x86_64"
elif [ "${ARCH}" = "i386" ]; then 
  PKG_MAKE_OPTS_TARGET+=" WITH_DYNAREC=x86"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/libretro/dosbox_core_libretro.so ${INSTALL}/usr/lib/libretro
}
