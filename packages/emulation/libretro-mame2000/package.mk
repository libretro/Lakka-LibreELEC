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

PKG_NAME="libretro-mame2000"
PKG_VERSION="1083de2"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2000-libretro"
PKG_URL="https://github.com/libretro/mame2000-libretro/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="mame2000-libretro-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="2000 version of MAME (0.37b5) for libretro"
PKG_LONGDESC="2000 version of MAME (0.37b5) for libretro"
PKG_AUTORECONF="no"
PKG_IS_ADDON="no"
PKG_USE_CMAKE="no"

PKG_LIBNAME="mame2000_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="MAME2000_LIB"

configure_target() {
  strip_lto
}

make_target() {
  case $PROJECT in
    RPi|RPi2|imx6|WeTek_Play|WeTek_Core)
      make ARM=1
      ;;
    Generic|Odroid_C2|WeTek_Hub|WeTek_Play_2)
      make
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME
  cp $PKG_LIBPATH $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME
  echo "set($PKG_LIBVAR $SYSROOT_PREFIX/usr/lib/$PKG_LIBNAME)" > $SYSROOT_PREFIX/usr/lib/cmake/$PKG_NAME/$PKG_NAME-config.cmake
}

