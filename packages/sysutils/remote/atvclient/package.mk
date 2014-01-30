################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="atvclient"
PKG_VERSION="0.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://github.com/Evinyatar/atvclient/wiki"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb-compat"
PKG_PRIORITY="optional"
PKG_SECTION="system/remote"
PKG_SHORTDESC="atvclient: a background application for Linux that reads input from the AppleTV’s internal infra-red receiver"
PKG_LONGDESC="atvclient is a background application for Linux that reads input from the AppleTV’s internal infra-red receiver and submits it to XBMC in a way very similar to how XBMCHelper does this under the native AppleTV OS. It implements most of the functionality the ATV OS HID driver supports, including pairing and control of the status LED."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

