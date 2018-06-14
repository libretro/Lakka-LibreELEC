################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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
PKG_VERSION="1.6.4"
PKG_SHA256="e4876dff281f948cdb57a44535627299c2333e6933fa06bfbc60c26cecd12fb1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="https://github.com/vpelletier/python-libusb1"
PKG_URL="https://github.com/vpelletier/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python2 distutilscross:host"
PKG_PRIORITY="optional"
PKG_SECTION="python"
PKG_SHORTDESC="Pure-python wrapper for libusb-1.0"
PKG_LONGDESC="Pure-python wrapper for libusb-1.0"
PKG_TOOLCHAIN="manual"

make_target() {
  python setup.py build
}
