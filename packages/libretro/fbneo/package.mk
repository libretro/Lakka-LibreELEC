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

PKG_NAME="fbneo"
PKG_VERSION="01bf2e1"
PKG_ARCH="any"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/fbneo"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Port of Final Burn Neo to Libretro"
PKG_LONGDESC="Currently, FB Neo supports games on Capcom CPS-1 and CPS-2 hardware, SNK Neo-Geo hardware, Toaplan hardware, Cave hardware, and various games on miscellaneous hardware. "
PKG_TOOLCHAIN="make"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET=" -C ./src/burner/libretro"

if [ "$ARCH" == "arm" ]; then
  PKG_MAKE_OPTS_TARGET+=" profile=performance"

  if [[ "$TARGET_FPU" =~ "neon" ]]; then
    PKG_MAKE_OPTS_TARGET+=" HAVE_NEON=1"
  fi

  if [ "$DEVICE" = "OdroidGoAdvance" ]; then
    PKG_MAKE_OPTS_TARGET+=" USE_CYCLONE=1"
  fi

else
  PKG_MAKE_OPTS_TARGET+=" profile=accuracy"
fi

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
    cp src/burner/libretro/fbneo_libretro.so $INSTALL/usr/lib/libretro/

  # copy DATs for manual content scanning
  mkdir -p $INSTALL/usr/share/libretro-database/fbneo
    cp dats/* $INSTALL/usr/share/libretro-database/fbneo

  # copy hiscore.dat to RetroArch system folder
  mkdir -p $INSTALL/usr/share/retroarch-system/fbneo
    cp metadata/hiscore.dat $INSTALL/usr/share/retroarch-system/fbneo
}
