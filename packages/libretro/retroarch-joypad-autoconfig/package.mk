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

PKG_NAME="retroarch-joypad-autoconfig"
PKG_VERSION="760b057"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/retroarch-joypad-autoconfig"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="RetroArch joypad autoconfig files"
PKG_LONGDESC="RetroArch joypad autoconfig files"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$DEVICE" = "RPi4-RetroDreamer" ]; then
  PKG_PATCH_DIRS+=" retrodreamer-patch"
fi

configure_target() {
  cd $PKG_BUILD
}

makeinstall_target() {
  make install INSTALLDIR="$INSTALL/etc/retroarch-joypad-autoconfig" DOC_DIR="$INSTALL/etc/doc/."
  
  #Remove non tested joycon configs
  rm "${INSTALL}"/etc/retroarch-joypad-autoconfig/udev/Nintendo\ -\ Switch\ Pro\ Controller\ \(bare\).cfg
  rm "${INSTALL}"/etc/retroarch-joypad-autoconfig/udev/Nintendo\ -\ Switch\ Pro\ Controller.cfg
  rm "${INSTALL}"/etc/retroarch-joypad-autoconfig/udev/Nintendo-Switch-Online_NES-Controller_Left.cfg
  rm "${INSTALL}"/etc/retroarch-joypad-autoconfig/udev/Nintendo-Switch-Online_NES-Controller_Right.cfg

  #Place Working configs
  cp -Pr "${PKG_DIR}"/joypad_configs/* "${INSTALL}"/etc/retroarch-joypad-autoconfig/  
}
