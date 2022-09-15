PKG_NAME="picodrive"
PKG_VERSION="bb6a52fe60e6f3bdcd17effe75e68fd0f8c44ba7"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/picodrive"
PKG_URL="https://github.com/libretro/picodrive/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain ${PKG_NAME}:host"
PKG_LONGDESC="Libretro implementation of PicoDrive. (Sega Megadrive/Genesis/Sega Master System/Sega GameGear/Sega CD/32X)"
PKG_TOOLCHAIN="manual"
PKG_DEPENDS_UNPACK="cyclone68000"

pre_build_host() {
  cp -a $(get_build_dir cyclone68000)/* ${PKG_BUILD}/cpu/cyclone/
}

pre_configure_host() {
  # fails to build in subdirs
  cd ${PKG_BUILD}
  rm -rf .${HOST_NAME}
}

make_host() {
  if [ "${ARCH}" = "arm" ]; then
    make -C cpu/cyclone CONFIG_FILE=../cyclone_config.h
  fi
}

pre_configure_target() {
  # fails to build in subdirs
  cd ${PKG_BUILD}
  rm -rf .${TARGET_NAME}
}

post_configure_target() {
  sed -e "s|^GIT_VERSION :=.*$|GIT_VERSION := \" ${PKG_VERSION:0:7}\"|" -i Makefile.libretro
}

make_target() {
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
    cp -v ../picodrive_libretro.so ${INSTALL}/usr/lib/libretro/
}
