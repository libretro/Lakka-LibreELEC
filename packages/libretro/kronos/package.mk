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

PKG_NAME="kronos"
PKG_VERSION="9bb35a8"
PKG_GIT_CLONE_BRANCH="kronos"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/yabause"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Port of Kronos to libretro."
PKG_LONGDESC="Port of Kronos to libretro."
PKG_TOOLCHAIN="make"

PKG_MAKE_OPTS_TARGET="-C yabause/src/libretro HAVE_CDROM=1"

if [ "$OPENGL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
  PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=1"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
  if [ "$OPENGLES" = "mesa" ]; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=1"
  fi
fi

if [ "$ARCH" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=armv"
elif [ "$ARCH" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=arm64"
  if [ "$PROJECT" == "Amlogic" ]; then
    PKG_MAKE_OPTS_TARGET+=" FORCE_GLES=1"
  fi
fi

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp yabause/src/libretro/kronos_libretro.so $INSTALL/usr/lib/libretro/
}
