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

PKG_NAME="beetle-psx"
PKG_VERSION="75bd155"
PKG_REV="1"
PKG_ARCH="x86_64 i386 aarch64"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/beetle-psx-libretro"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Standalone port of Mednafen PSX to libretro."
PKG_LONGDESC="Standalone port of Mednafen PSX to libretro."
PKG_TOOLCHAIN="make"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$OPENGL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
fi

if [ "$VULKAN_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $VULKAN"
fi

PKG_MAKE_OPTS_TARGET="HAVE_CDROM=1 LINK_STATIC_LIBCPLUSPLUS=0"

if [ "$OPENGL_SUPPORT" = yes -a "$VULKAN_SUPPORT" = yes ]; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_HW=1"
elif [ "$OPENGL_SUPPORT" = yes ]; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=1"
elif [ "$VULKAN_SUPPORT" = yes ]; then
  PKG_MAKE_OPTS_TARGET+=" HAVE_VULKAN=1"
fi

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp *.so $INSTALL/usr/lib/libretro/
}
