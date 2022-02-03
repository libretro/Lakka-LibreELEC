# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="pcsc-lite"
PKG_VERSION="1.9.0"
PKG_SHA256="0148d403137124552c5d0f10f8cdab2cbb8dfc7c6ce75e018faf667be34f2ef9"
PKG_LICENSE="GPL"
PKG_SITE="https://pcsclite.apdu.fr"
PKG_URL="https://pcsclite.apdu.fr/files/pcsc-lite-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_LONGDESC="Middleware to access a smart card using SCard API (PC/SC)."

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
            --enable-static \
            --disable-libudev \
            --enable-libusb \
            --enable-usbdropdir=/storage/.kodi/addons/service.pcscd/drivers"

post_configure_target() {
  libtool_remove_rpath libtool
}
