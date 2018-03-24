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

PKG_NAME="libretro-mame2010"
PKG_VERSION="3a9d2ff"
PKG_SHA256="e60cad55518281516778b943723b6d1ae4a17b096124f108dd27520862175f5b"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2010-libretro"
PKG_URL="https://github.com/libretro/mame2010-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="mame2010-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="Late 2010 version of MAME (0.139) for libretro"
PKG_LONGDESC="Late 2010 version of MAME (0.139) for libretro"
PKG_BUILD_FLAGS="-lto"

PKG_LIBNAME="mame2010_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MAME2010_LIB"

pre_make_target() {
  export CFLAGS="$CFLAGS -fpermissive"
  export CXXFLAGS="$CXXFLAGS -fpermissive"
  export LD="$CXX"
}

make_target() {
  case $TARGET_CPU in
    arm1176jzf-s)
      make platform=armv6-hardfloat-$TARGET_CPU
      ;;
    cortex-a7|cortex-a9)
      make platform=armv7-neon-hardfloat-$TARGET_CPU
      ;;
    *cortex-a53|cortex-a17)
      if [ "$TARGET_ARCH" = "aarch64" ]; then
        make platform=aarch64
      else
        make platform=armv7-neon-hardfloat-cortex-a9
      fi
      ;;
    x86-64)
      make
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}
