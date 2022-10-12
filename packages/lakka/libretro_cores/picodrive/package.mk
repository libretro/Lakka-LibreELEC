PKG_NAME="picodrive"
PKG_VERSION="26719f348eb579a8372e2c58ef0132d95d9dc817"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/picodrive"
PKG_URL="${PKG_SITE}.git"
PKG_DEPENDS_TARGET="toolchain ${PKG_NAME}:host"
PKG_LONGDESC="Libretro implementation of PicoDrive. (Sega Megadrive/Genesis/Sega Master System/Sega GameGear/Sega CD/32X)"
PKG_TOOLCHAIN="manual"

make_target() {
  cd ${PKG_BUILD}
  if target_has_feature neon; then
    export HAVE_NEON=1
    export BUILTIN_GPU=neon
   else
    export HAVE_NEON=0
  fi

  case ${TARGET_ARCH} in
    aarch64)
      R= make -f Makefile.libretro platform=aarch64
      ;;
    arm)
      R= make -f Makefile.libretro platform=armv
      ;;
    x86_64)
      R= make -f Makefile.libretro
      ;;
  esac
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
    cp -v picodrive_libretro.so ${INSTALL}/usr/lib/libretro/
}
