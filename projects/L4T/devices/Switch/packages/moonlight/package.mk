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

PKG_NAME="moonlight"
PKG_VERSION="20d2d77"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/rock88/moonlight-libretro"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain ffmpeg opus"
PKG_SECTION="libretro"
PKG_SHORTDESC="Moonlight-libretro is a port of Moonlight Game Streaming Project for RetroArch platform."
PKG_LONGDESC="Moonlight-libretro is a port of Moonlight Game Streaming Project for RetroArch platform."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make platform=lakka-switch TOOLCHAIN=${TOOLCHAIN}
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp moonlight_libretro.so $INSTALL/usr/lib/libretro/
}
