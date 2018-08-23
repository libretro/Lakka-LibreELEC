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

PKG_NAME="higan-sfc-balanced"
PKG_VERSION="5e965d0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/libretro/nSide"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="A fork of higan v106 by byuu, which was renamed to exclude \"higan\" at byuu's request."
PKG_LONGDESC="$PKG_SHORTDESC"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  cd $PKG_BUILD/nSide
  make -f GNUmakefile compiler=$TOOLCHAIN/bin/$TARGET_NAME-g++ target=libretro binary=library
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp out/higan_sfc_balanced_libretro.so $INSTALL/usr/lib/libretro/
}
