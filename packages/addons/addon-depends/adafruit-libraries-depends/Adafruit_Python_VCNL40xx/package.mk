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

PKG_NAME="Adafruit_Python_VCNL40xx"
PKG_VERSION="e54bff9"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/adafruit/${PKG_NAME}"
PKG_URL="https://github.com/adafruit/${PKG_NAME}/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host"
PKG_SECTION="python"
PKG_SHORTDESC="Adafruit Python VCNL40xx Library"
PKG_LONGDESC="Python code to use the VCNL4000 & VCNL4010 proximity sensors with the Raspberry Pi & BeagleBone Black."
PKG_AUTORECONF="no"

make_target() {
  : # nop
}

makeinstall_target() {
  : # nop
}
