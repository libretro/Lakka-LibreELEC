################################################################################
#      This file is part of LibreELEC - http://www.libreelec.tv
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

PKG_NAME="mame2015"
PKG_VERSION="ef41361"
PKG_REV="1"
PKG_ARCH="x86_64 aarch64 arm"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2015-libretro"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="libretro"
PKG_SHORTDESC="Late 2014/Early 2015 version of MAME (0.160-ish) for libretro and MAME 0.160 romsets"
PKG_BUILD_FLAGS="-lto"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_make_target() {
  export REALCC=$CC
  export CC=$CXX
  export LD=$CXX
}

make_target() {
  case ${DEVICE:-$PROJECT} in
    RPi)
      make platform=armv6-hardfloat-arm1176jzf-s
      ;;
    RPi2)
      make platform=armv7-neon-hardfloat-cortex-a7
      ;;
    imx6)
      make platform=armv7-neon-hardfloat-cortex-a9
      ;;
    WeTek_Play)
      make platform=armv7-neon-hardfloat-cortex-a9
      ;;
    Odroid_C2|WeTek_Hub|WeTek_Play_2)
      make platform=armv-neon-hardfloat
      ;;
    Generic|Switch)
      make
      ;;
    *)
      if [ ${PROJECT} = "RPi" -a ${ARCH} = "aarch64" ]; then
        make
      else
        make platform=armv
      fi
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp mame2015_libretro.so $INSTALL/usr/lib/libretro/
}
