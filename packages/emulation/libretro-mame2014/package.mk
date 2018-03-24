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

PKG_NAME="libretro-mame2014"
PKG_VERSION="49f55c1"
PKG_SHA256="c1f018dbbf8dcc43df66e4ad10431812981db1e3a794485c41799b2a43f8d834"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2014-libretro"
PKG_URL="https://github.com/libretro/mame2014-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="mame2014-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="Late 2014/Early 2015 version of MAME (0.159-ish) for libretro"
PKG_LONGDESC="Late 2014/Early 2015 version of MAME (0.159-ish) for libretro"
PKG_BUILD_FLAGS="-lto"

PKG_LIBNAME="mame2014_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MAME2014_LIB"

pre_make_target() {
  export REALCC=$CC
  export CC=$CXX
  export LD=$CXX
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
