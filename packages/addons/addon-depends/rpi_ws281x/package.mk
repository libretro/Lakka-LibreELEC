################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="rpi_ws281x"
PKG_VERSION="3e6ea50"
PKG_ARCH="any"
PKG_LICENSE=""
PKG_SITE="https://github.com/hyperion-project/rpi_ws281x"
PKG_URL="https://github.com/hyperion-project/rpi_ws281x/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION=""
PKG_SHORTDESC="Userspace Raspberry Pi PWM library for WS281X LEDs"
PKG_LONGDESC="Userspace Raspberry Pi PWM library for WS281X LEDs"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  :
}

makeinstall_target() {
  :
}
