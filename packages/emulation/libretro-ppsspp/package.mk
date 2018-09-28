# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-ppsspp"
PKG_VERSION="bd678d4f4be7a3aad3d5dc9f0698be97e1baf755"
PKG_SHA256="fd7af56fc7a7136d635a296e4c7151da4df4259d565b2f4ccf59e57475da8352"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/hrydgard/ppsspp"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain glew kodi-platform SDL2 zlib"
PKG_SECTION="emulation"
PKG_SHORTDESC="A PSP emulator for Android, Windows, Mac, Linux and Blackberry 10, written in C++."
PKG_LONGDESC="A PSP emulator for Android, Windows, Mac, Linux and Blackberry 10, written in C++."
PKG_TOOLCHAIN="cmake-make"

PKG_LIBNAME="ppsspp_libretro.so"
PKG_LIBPATH="lib/$PKG_LIBNAME"
PKG_LIBVAR="PPSSPP_LIB"

PKG_CMAKE_OPTS_TARGET="-DLIBRETRO=ON"

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
