PKG_NAME="dosbox_svn"
PKG_VERSION="c23be7769518d753378307996de35e204d188c63"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/dosbox-svn"
PKG_URL="${PKG_SITE}.git"
PKG_GIT_CLONE_BRANCH="libretro"
PKG_DEPENDS_TARGET="toolchain SDL_net"
PKG_LONGDESC="Upstream port of DOSBox to libretro"
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C libretro WITH_EMBEDDED_SDL=0"

if [ "${ARCH}" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" target=arm64"
elif [ "${ARCH}" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" target=arm"
elif [ "${ARCH}" = "x86_64" ]; then
  PKG_MAKE_OPTS_TARGET+=" target=x86_64"
elif [ "${ARCH}" = "i386" ]; then 
  PKG_MAKE_OPTS_TARGET+=" target=x86"
fi

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/libretro/dosbox_svn_libretro.so ${INSTALL}/usr/lib/libretro
}
