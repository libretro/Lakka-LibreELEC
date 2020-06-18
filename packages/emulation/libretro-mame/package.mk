# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame"
PKG_VERSION="cdff081ffdd0f4b599874d9f8e18b0fe008b75a7"
PKG_SHA256="cac90f3d9876f44a9e377cf60ccb06c1bb6a11425ec07cdedb9473fc8adb988d"
PKG_ARCH="x86_64 arm"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame"
PKG_URL="https://github.com/libretro/mame/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_LONGDESC="game.libretro.mame: MAME for Kodi"
PKG_BUILD_FLAGS="-gold -lto"
PKG_TOOLCHAIN="make"

PKG_LIBNAME="mame_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MAME_LIB"

make_target() {
  PTR64="0"
  NOASM="0"

  if [ "$ARCH" == "arm" ]; then
    NOASM="1"
  elif [ "$ARCH" == "x86_64" ]; then
    PTR64="1"
  fi

  make REGENIE=1 VERBOSE=1 NOWERROR=1 PYTHON_EXECUTABLE=python2 CONFIG=libretro \
       LIBRETRO_OS="unix" ARCH="" PROJECT="" LIBRETRO_CPU="$ARCH" DISTRO="debian-stable" \
       CROSS_BUILD="1" OVERRIDE_CC="$CC" OVERRIDE_CXX="$CXX" \
       PTR64="$PTR64" TARGET="mame" \
       SUBTARGET="arcade" PLATFORM="$ARCH" RETRO=1 OSD="retro"
}

post_make_target() {
  mv $PKG_BUILD/mamearcade_libretro.so $PKG_BUILD/mame_libretro.so
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
