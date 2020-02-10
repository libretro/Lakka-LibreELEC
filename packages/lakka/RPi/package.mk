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

PKG_NAME="RPi"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/libretro/Lakka-LibreELEC"
PKG_URL=""
PKG_DEPENDS_TARGET="retroarch"

if [ "$DEVICE" = "RPi" -o "$DEVICE" = "RPi2" ] ; then
  PKG_DEPENDS_TARGET+=" wii-u-gc-adapter wiringPi"
fi

if [ "$DEVICE" = "Gamegirl" ]; then
  PKG_DEPENDS_TARGET+=" gamegirl-joypad"
fi

if [ "$DEVICE" = "GPICase" ]; then
  PKG_DEPENDS_TARGET+=" gpicase-safeshutdown"
fi

PKG_PRIORITY="optional"
PKG_SECTION="virtual"
PKG_SHORTDESC="Lakka metapackage for RPi devices"
PKG_LONGDESC=""

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_install() {
  if [ "$DEVICE" = "GPICase" ]; then
    enable_service disable-hdmi.service
  fi
}
