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

PKG_NAME="Adafruit_Python_SI1145"
PKG_VERSION="cbc6c62"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/THP-JOE/Python_SI1145"
PKG_URL="https://github.com/THP-JOE/Python_SI1145/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="Python_SI1145-$PKG_VERSION*"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host"
PKG_SECTION="python"
PKG_SHORTDESC="Python library for the SI1145"
PKG_LONGDESC="Python library for accessing the SI1145 temperature sensor on a Raspberry Pi"
PKG_AUTORECONF="no"

make_target() {
  : # nop
}

makeinstall_target() {
  : # nop
}

