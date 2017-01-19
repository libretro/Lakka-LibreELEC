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

PKG_NAME="python-libusb1"
PKG_VERSION="1.5.3"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/vpelletier/python-libusb1"
PKG_URL="https://github.com/vpelletier/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host"
PKG_PRIORITY="optional"
PKG_SECTION="python"
PKG_SHORTDESC="Pure-python wrapper for libusb-1.0"
PKG_LONGDESC="Pure-python wrapper for libusb-1.0"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  python setup.py build
}

makeinstall_target() {
  :
}
