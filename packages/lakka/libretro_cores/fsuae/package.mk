PKG_NAME="fsuae"
PKG_VERSION="6b98f852e00a83ecdcf497c1032882ad7b6efc99"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-fsuae"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain libmpeg2 openal-soft glib"
PKG_LONGDESC="FS-UAE amiga emulator libretro core."
#PKG_BUILD_FLAGS="-lto"
PKG_TOOLCHAIN="configure"

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

if [ "$PROJECT" = "RPi" ] ; then
    PKG_CONFIGURE_OPTS_TARGET="--disable-jit --enable-neon"
fi

pre_configure_target() {
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}
  export ac_cv_func_realloc_0_nonnull=yes
}

make_target() {
  make CC=${HOST_CC} CFLAGS= gen
  make CC=${CC}
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v fsuae_libretro.so ${INSTALL}/usr/lib/libretro/

  mkdir -p ${INSTALL}/usr/share/fs-uae
    cp -v fs-uae.dat ${INSTALL}/usr/share/fs-uae/
}
