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

PKG_NAME="vecx"
PKG_VERSION="0f3f04b"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2|LGPLv2.1"
PKG_SITE="https://github.com/libretro/libretro-vecx"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="libretro adaptation of vecx"
PKG_LONGDESC="libretro adaptation of vecx"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$OPENGL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
fi

make_target() {
  if [ "$PROJECT" == "RPi" ]; then
    if [ "$DEVICE" == "RPi4" ]; then
	make platform=rpi-mesa -f Makefile.libretro # Use mesa gl/gles
    else
	make platform=rpi -f Makefile.libretro # broadcom gl/gles
    fi
  elif [ "$OPENGLES_SUPPORT" = "yes" ]; then
    make HAS_GLES=1 GLES=1 -f Makefile.libretro
  else
    make -f Makefile.libretro
 fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp vecx_libretro.so $INSTALL/usr/lib/libretro/vecx_libretro.so
}
