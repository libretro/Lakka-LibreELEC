# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-picodrive"
PKG_VERSION="67cdfb8c5d407c5a4e8f25ffa0ee7fac716b0690"
PKG_SHA256="39871c4c5d2af833a4ae56ef83cfe21102edc563b728f00c56d50de9857cbf1e"
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
