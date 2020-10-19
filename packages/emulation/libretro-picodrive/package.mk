# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-picodrive"
PKG_VERSION="5e77a40fd4bcdaf7d91056e1a0e72330315a6189"
PKG_SHA256="c460a3ec53aa30a0e3cd2e2287f4a6e9957d66539340907d9d1568d4f2bde327"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/picodrive"
PKG_URL="https://github.com/libretro/picodrive/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain kodi-platform $PKG_NAME:host"
PKG_DEPENDS_UNPACK="cyclone68000"
PKG_LONGDESC="Fast MegaDrive/MegaCD/32X emulator"
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="-gold"

PKG_LIBNAME="picodrive_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="PICODRIVE_LIB"

pre_build_host() {
  cp -a $(get_build_dir cyclone68000)/* $PKG_BUILD/cpu/cyclone/
}

pre_configure_host() {
  # fails to build in subdirs
  cd $PKG_BUILD
  rm -rf .$HOST_NAME
}

make_host() {
  if [ "$ARCH" = "arm" ]; then
    make -C cpu/cyclone CONFIG_FILE=../cyclone_config.h
  fi
}

pre_configure_target() {
  # fails to build in subdirs
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
}

post_configure_target() {
  sed -e "s|^GIT_VERSION :=.*$|GIT_VERSION := \" ${PKG_VERSION:0:7}\"|" -i Makefile.libretro
}

make_target() {
  R= make -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
