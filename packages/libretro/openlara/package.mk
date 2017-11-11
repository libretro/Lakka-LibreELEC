################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="openlara"
PKG_VERSION="c975393"
PKG_REV="1"
PKG_ARCH="i386 x86_64"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/libretro/openlara"
PKG_URL="https://github.com/libretro/openlara/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Classic Tomb Raider open-source engine"
PKG_LONGDESC="Classic Tomb Raider open-source engine"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  case $PROJECT in
    RPi|RPi2|Gamegirl)
      CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads \
                      -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
      make -C src/platform/libretro GLES=1
      ;;
    imx6)
      CFLAGS="$CFLAGS -DLINUX -DEGL_API_FB"
      CPPFLAGS="$CPPFLAGS -DLINUX -DEGL_API_FB"
      make -C src/platform/libretro
      ;;
    *)
      make -C src/platform/libretro
      ;;
  esac
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp src/platform/libretro/*_libretro.so $INSTALL/usr/lib/libretro/
}
