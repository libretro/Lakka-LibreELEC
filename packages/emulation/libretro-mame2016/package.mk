# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2016"
PKG_VERSION="e06d731644217f46bf5a7613222632d41a327f93"
PKG_SHA256="60a8aaab5158868419f24cc0671f8bcba0a578aae46cae7b9482e2c332784553"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2016-libretro"
PKG_URL="https://github.com/libretro/mame2016-libretro/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Late 2016 version of MAME (0.174) for libretro. Compatible with MAME 0.174 romsets"
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-gold"

PKG_LIBNAME="mame2016_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MAME2016_LIB"

make_target() {
  PTR64="1"
  NOASM="0"

  make REGENIE=1 VERBOSE=1 NOWERROR=1 PYTHON_EXECUTABLE=python2 CONFIG=libretro \
       LIBRETRO_OS="unix" ARCH="" PROJECT="" LIBRETRO_CPU="$ARCH" DISTRO="debian-stable" \
       CC="$CC" CXX="$CXX" LD="$LD" CROSS_BUILD="" PTR64="$PTR64" TARGET="mame" \
       SUBTARGET="arcade" PLATFORM="$ARCH" RETRO=1 OSD="retro"
}

post_make_target() {
  mv $PKG_BUILD/mamearcade2016_libretro.so $PKG_BUILD/mame2016_libretro.so
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
