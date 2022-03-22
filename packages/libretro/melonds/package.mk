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

PKG_NAME="melonds"
PKG_VERSION="e93ec3e"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/melonds"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="DS emulator, sorta"
PKG_LONGDESC="DS emulator, sorta"
PKG_TOOLCHAIN="make"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$OPENGL_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGL"
  PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=1 HAVE_OPENGLES3=0"
fi

if [ "$OPENGLES_SUPPORT" = yes ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
  PKG_MAKE_OPTS_TARGET+=" HAVE_OPENGL=0 HAVE_OPENGLES3=1"
fi

if [ "$ARCH" = "aarch64" ]; then
  PKG_MAKE_OPTS_TARGET+=" ARCH=arm64"
  if [ "$PROJECT" = "L4T" ]; then
    PKG_MAKE_OPTS_TARGET+=" platform=tegra210"
  else
    PKG_MAKE_OPTS_TARGET+=" platform=unix"
  fi
elif [ "$ARCH" = "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" platform=unix"
  if target_has_feature neon ; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
  fi
fi

pre_make_target() {
  cd $PKG_BUILD
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp melonds_libretro.so $INSTALL/usr/lib/libretro/
}
