# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-ppsspp"
PKG_VERSION="7b4ddb426bbe9e287bb7f19b0cfaebb4ea0d41d8"
PKG_SHA256="e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_LONGDESC="A PSP emulator written in C++."
PKG_TOOLCHAIN="cmake-make"

PKG_LIBNAME="ppsspp_libretro.so"
PKG_LIBPATH="lib/$PKG_LIBNAME"
PKG_LIBVAR="PPSSPP_LIB"

if target_has_feature neon; then
  PKG_ARCH_ARM="-DARMV7=ON \
                -DUSING_FBDEV=ON \
                -DUSING_EGL=ON \
                -DUSING_GLES2=ON \
                -DUSING_X11_VULKAN=OFF"
fi

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                       -DUSE_SYSTEM_FFMPEG=ON \
                       $PKG_ARCH_ARM"

pre_configure_target() {
  LDFLAGS="$LDFLAGS -lpthread"
}

pre_make_target() {
  find . -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
