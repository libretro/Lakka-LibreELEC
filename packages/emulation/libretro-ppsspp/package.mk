# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-ppsspp"
PKG_VERSION="caa506bf2a253a99850a4248a1cb5a399f32467a"
PKG_SHA256="d59b4d044b761a73e744ab71e207e5b3bdbac819ed2201b79ed4455606ac0719"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain SDL2"
PKG_LONGDESC="A PSP emulator written in C++."
PKG_TOOLCHAIN="cmake-make"

PKG_LIBNAME="ppsspp_libretro.so"
PKG_LIBPATH="lib/$PKG_LIBNAME"
PKG_LIBVAR="PPSSPP_LIB"

if [ "$PROJECT" = "Amlogic" ] || [ "$PROJECT" = "RPi" ]; then
  case $DEVICE in
     KVIM|RPi2|S905|Odroid_C2)
      PKG_ARCH_ARM="-DARMV7=ON \
                -DUSING_FBDEV=ON \
                -DUSING_EGL=ON \
                -DUSING_GLES2=ON \
                -DUSING_X11_VULKAN=OFF"
     ;;
  esac
fi

pre_configure_target() {
  LDFLAGS="$LDFLAGS -lpthread"
}

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON \
                       -DUSE_SYSTEM_FFMPEG=ON \
                       $PKG_ARCH_ARM"

pre_make_target() {
  find . -name flags.make -exec sed -i "s:isystem :I:g" \{} \;
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
