################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="libretro-ppsspp"
PKG_VERSION="9145287"
PKG_SHA256="e209a04cd076855e4a8e644ddb1035eda919d81adef7ed1321de5b9f2fce8881"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/libretro-ppsspp"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="A PSP emulator for Android, Windows, Mac, Linux and Blackberry 10, written in C++."
PKG_LONGDESC="A PSP emulator for Android, Windows, Mac, Linux and Blackberry 10, written in C++."
PKG_TOOLCHAIN="make"
PKG_BUILD_FLAGS="-lto"

PKG_LIBNAME="ppsspp_libretro.so"
PKG_LIBPATH="libretro/$PKG_LIBNAME"
PKG_LIBVAR="PPSSPP_LIB"

pre_configure_target() {
  # fails to build in subdirs
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
}

pre_make_target() {
  export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads"
  export CXXFLAGS="$CXXFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads"
}

make_target() {
  if [ -z "$DEVICE" ]; then
    PKG_DEVICE_NAME=$PROJECT
  else
    PKG_DEVICE_NAME=$DEVICE
  fi
  
  if [ "$PKG_DEVICE_NAME" = "RPi" ]; then
    make -C libretro platform=${DEVICE,,}
  else
    case $TARGET_CPU in
      arm1176jzf-s)
        make -C libretro CC=$CC CXX=$CXX platform=armv6-gles-hardfloat-$TARGET_CPU
        ;;
      cortex-a7|cortex-a9)
        make -C libretro CC=$CC CXX=$CXX platform=armv7-neon-gles-hardfloat-$TARGET_CPU
        ;;
      x86-64)
        make -C libretro CC=$CC CXX=$CXX
        ;;
    esac
  fi
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
