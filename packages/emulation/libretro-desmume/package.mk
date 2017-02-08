################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="libretro-desmume"
PKG_VERSION="1dd58e4"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/desmume-libretro"
PKG_URL="https://github.com/libretro/desmume-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="desmume-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="libretro wrapper for desmume NDS emulator."
PKG_LONGDESC="libretro wrapper for desmume NDS emulator."
PKG_AUTORECONF="no"
PKG_IS_ADDON="no"
PKG_USE_CMAKE="no"

PKG_LIBNAME="desmume_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="DESMUME_LIB"

make_target() {
  case $PROJECT in
    RPi)
      make -f Makefile.libretro platform=armv6-hardfloat-arm1176jzf-s
      ;;
    RPi2)
      make -f Makefile.libretro platform=armv7-neon-hardfloat-cortex-a7
      ;;
    imx6)
      make -f Makefile.libretro platform=armv7-neon-hardfloat-cortex-a9
      ;;
    WeTek_Play|WeTek_Core)
      make -f Makefile.libretro platform=armv7-neon-hardfloat-cortex-a9
      ;;
    Generic)
      make -f Makefile.libretro
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}

