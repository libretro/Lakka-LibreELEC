PKG_NAME="hatari"
PKG_VERSION="7008194d3f951a157997f67a820578f56f7feee0"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/hatari"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="New rebasing of Hatari based on Mercurial upstream. Tries to be a shallow fork for easy upstreaming later on."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C ../ -f Makefile.libretro"

pre_make_target() {
  if [ "${ARCH}" = "arm" ]; then
    CFLAGS+=" -DNO_ASM -DARM -D__arm__ -DARM_ASM -DNOSSE -DARM_HARDFP"
  fi
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v ../hatari_libretro.so ${INSTALL}/usr/lib/libretro/
}
