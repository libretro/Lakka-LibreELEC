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

PKG_NAME="pcsc-lite"
PKG_VERSION="1.8.22"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://pcsclite.alioth.debian.org/pcsclite.html"
PKG_URL="https://alioth.debian.org/frs/download.php/latestfile/39/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_SECTION="service/system"
PKG_SHORTDESC="Middleware to access a smart card using SCard API (PC/SC)"
PKG_LONGDESC="Middleware to access a smart card using SCard API (PC/SC)"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
            --enable-static \
            --disable-libudev \
            --enable-libusb \
            --enable-usbdropdir=/storage/.kodi/addons/service.pcscd/drivers"
