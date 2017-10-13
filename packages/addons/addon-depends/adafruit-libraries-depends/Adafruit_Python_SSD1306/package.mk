################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

PKG_NAME="Adafruit_Python_SSD1306"
PKG_VERSION="b7eccd1"
PKG_SHA256="eb9d6a1387557681d5f86dbdaa4acd96de74aeccbad57bae647c6da947f9e044"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/adafruit/${PKG_NAME}"
PKG_URL="https://github.com/adafruit/${PKG_NAME}/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_SECTION="python"
PKG_SHORTDESC="Adafruit Python SSD1306 Library"
PKG_LONGDESC="SSD1306 oled driver library for 'monochrome' 128x64 and 128x32 OLEDs."
PKG_AUTORECONF="no"

make_target() {
  : # nop
}

makeinstall_target() {
  : # nop
}
