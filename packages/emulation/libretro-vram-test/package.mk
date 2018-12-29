# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-vram-test"
PKG_VERSION="6b90ce9"
PKG_SHA256="2bd1b3af783a028355eb4b4c416f09802313a9a69759e716377b55012f7bb4ae"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/libretro/libretro-samples"
PKG_URL="https://github.com/libretro/libretro-samples/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="VRAM Test from libretro"
PKG_TOOLCHAIN="manual"

PKG_LIBNAME="testsw_vram_libretro.so"
PKG_LIBVAR="VRAM-TEST_LIB"

configure_package() {
  PKG_LIBPATH="$PKG_BUILD/video/software/rendering_direct_to_vram/$PKG_LIBNAME"
}

make_target() {
  cd $PKG_BUILD/video/software/rendering_direct_to_vram
  make
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
