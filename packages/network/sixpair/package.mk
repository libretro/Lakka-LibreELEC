################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="sixpair"
PKG_VERSION="23e6e08"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.pabr.org/sixlinux/"
PKG_URL="https://github.com/lakkatv/sixpair/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libusb libusb-compat"
PKG_SECTION="network"
PKG_SHORTDESC="Associate PS3 Sixaxis controller to system bluetoothd via USB"
PKG_LONGDESC="Associate PS3 Sixaxis controller to system bluetoothd via USB"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make sixpair LDLIBS=-lusb
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp sixpair $INSTALL/usr/bin
}
