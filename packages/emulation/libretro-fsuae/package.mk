# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-fsuae"
PKG_VERSION="d4493d6e9499821956ca39fa42be371c23b22b62"
PKG_SHA256="68a8b5c9714ab70f34d772ab9110eaab324c6b35939d4cd495189aba308cae7a"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/libretro-fsuae"
PKG_URL="https://github.com/libretro/libretro-fsuae/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libmpeg2 openal-soft"
PKG_LONGDESC="FS-UAE amiga emulator."
PKG_BUILD_FLAGS="-lto"
PKG_TOOLCHAIN="autotools"

PKG_LIBNAME="fsuae_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="FSUAE_LIB"

if [ "$TARGET_ARCH" = "arm" ] && target_has_feature neon; then
  PKG_CONFIGURE_OPTS_TARGET="--disable-jit --enable-neon"
fi

pre_configure_target() {
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
  export ac_cv_func_realloc_0_nonnull=yes
}

make_target() {
  make -j1 CC="$CC" gen
  make CC="$CC"
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
