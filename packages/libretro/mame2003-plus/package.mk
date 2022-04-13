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

PKG_NAME="mame2003-plus"
PKG_VERSION="e5ee29e"
PKG_ARCH="any"
PKG_LICENSE="MAME"
PKG_SITE="https://github.com/libretro/mame2003-plus-libretro"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="MAME - Multiple Arcade Machine Emulator"
PKG_LONGDESC="MAME - Multiple Arcade Machine Emulator"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make ARCH="" CC="$CC" NATIVE_CC="$CC" LD="$CC"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
    cp mame2003_plus_libretro.so $INSTALL/usr/lib/libretro/

  mkdir -p $INSTALL/usr/share/libretro-database/mame2003-plus
    cp metadata/mame2003-plus.xml $INSTALL/usr/share/libretro-database/mame2003-plus

  mkdir -p $INSTALL/usr/share/retroarch-system/mame2003-plus/samples
    cp -r metadata/artwork $INSTALL/usr/share/retroarch-system/mame2003-plus
    cp metadata/{cheat,hiscore,history}.dat $INSTALL/usr/share/retroarch-system/mame2003-plus
    # something must be in a folder in order to include it in the image, so why not some instructions
    echo "Put your samples here." > $INSTALL/usr/share/retroarch-system/mame2003-plus/samples/readme.txt
}
