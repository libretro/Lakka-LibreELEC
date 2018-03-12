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

PKG_NAME="libusb"
PKG_VERSION="1.0.21"
PKG_SHA256="7dce9cce9a81194b7065ee912bcd55eeffebab694ea403ffb91b67db66b1824b"
PKG_ARCH="any"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="http://libusb.info/"
PKG_URL="$SOURCEFORGE_SRC/libusb/files/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain systemd"
PKG_SECTION="system"
PKG_SHORTDESC="libusb: OS independent USB device access"
PKG_LONGDESC="The libusb project's aim is to create a Library for use by user level applications to USB devices regardless of OS."
#libusb sometimes fails to build if building paralell
PKG_BUILD_FLAGS="-parallel"

PKG_CONFIGURE_OPTS_TARGET="--enable-shared \
            --enable-static \
            --disable-log \
            --disable-debug-log \
            --enable-udev \
            --disable-examples-build"
