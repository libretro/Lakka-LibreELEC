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

PKG_NAME="libretro-pcsx-rearmed"
PKG_VERSION="09d454e"
PKG_SHA256="1fb2a82fc7c4e455ac9e9786d9e263dd4ef2a877783d8c1503c8f12b730330c5"
PKG_ARCH="arm"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/pcsx_rearmed"
PKG_URL="https://github.com/libretro/pcsx_rearmed/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="pcsx_rearmed-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain kodi-platform"
PKG_SECTION="emulation"
PKG_SHORTDESC="game.libretro.pcsx-rearmed: PCSX Rearmed for Kodi"
PKG_LONGDESC="game.libretro.pcsx-rearmed: PCSX Rearmed for Kodi"
PKG_AUTORECONF="no"
PKG_USE_CMAKE="no"

PKG_LIBNAME="pcsx_rearmed_libretro.so"
PKG_LIBPATH="$PKG_LIBNAME"
PKG_LIBVAR="PCSX-REARMED_LIB"

configure_target() {
  :
}

pre_make_target() {
  strip_gold
}

make_target() {
  cd $PKG_BUILD
  case $PROJECT in
    RPi)
      case $DEVICE in
        RPi)
          make -f Makefile.libretro platform=armv6-hardfloat-arm1176jzf-s
          ;;
        RPi2)
          make -f Makefile.libretro platform=armv7-neon-hardfloat-cortex-a7
          ;;
      esac
      ;;
    imx6)
      make -f Makefile.libretro platform=armv7-neon-hardfloat-cortex-a9
      ;;
    WeTek_Play|WeTek_Core|Odroid_C2|WeTek_Hub|WeTek_Play_2)
      if [ "$TARGET_ARCH" = "aarch64" ]; then
        make -f Makefile.libretro platform=aarch64
      else
        make -f Makefile.libretro platform=armv7-neon-hardfloat-cortex-a9
      fi
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
