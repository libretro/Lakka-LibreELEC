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

PKG_NAME="uzebox"
PKG_VERSION="3c1988c"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/t-paul/uzebox"
PKG_URL="https://github.com/t-paul/uzebox/archive/$PKG_VERSION.tar.gz"
PKG_PATCH_DIRS="libretro"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="A retro-minimalist game console engine for the ATMega644"
PKG_LONGDESC="A retro-minimalist game console engine for the ATMega644"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make -C tools/uzem CPPFLAGS="$CFLAGS -I. $LDFLAGS -DNOGDB=1" CC="$CXX" LIBRETRO_BUILD=1
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp tools/uzem/uzem_libretro.so $INSTALL/usr/lib/libretro/
}
