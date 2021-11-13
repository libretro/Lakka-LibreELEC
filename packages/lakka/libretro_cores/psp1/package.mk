PKG_NAME="psp1"
PKG_VERSION="edf1cb70cc01c9f4ce81a83e1538c7b5ab7a2658"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/PSP1"
PKG_URL="${LAKKA_MIRROR}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_LONGDESC="Non-shallow fork of PPSSPP for libretro exclusively."
#PKG_BUILD_FLAGS="-lto"

pre_make_target() {
  PKG_MAKE_OPTS_TARGET="-C ${PKG_BUILD}/libretro"

  if [ "${ARCH}" = "arm" ]; then
    PKG_MAKE_OPTS_TARGET+="SYSROOT_PREFIX=${SYSROOT_PREFIX} platform=imx6"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ${PKG_BUILD}/libretro/ppsspp_libretro.so ${INSTALL}/usr/lib/libretro/
}
