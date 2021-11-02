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

PKG_NAME="switch-joycon-bluetooth-dock-configs"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/lakkatv/Lakka"
PKG_URL=""
PKG_DEPENDS_TARGET="joycond rewritefs xdotool"
PKG_PRIORITY="optional"
PKG_SECTION="virtual"
PKG_SHORTDESC="Scripts for docking, and pairing joycons. Bluez config mount"
PKG_LONGDESC=""

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_install() {
  enable_service xorg-configure-switch.service
  enable_service var-bluetoothconfig.mount
  enable_service pair-joycon.service

  mkdir -p "${INSTALL}"/usr/bin
  cp -P "${PKG_DIR}"/scripts/pair-joycon.sh "${INSTALL}"/usr/bin
  cp -P "${PKG_DIR}"/scripts/dock-hotplug "${INSTALL}"/usr/bin
  chmod +x "${INSTALL}"/usr/bin/pair-joycon.sh
  chmod +x "${INSTALL}"/usr/bin/dock-hotplug

}

