# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libgudev"
PKG_VERSION="235"
PKG_SHA256="36360e7629b762b0cc85ef302b88a7cea96b0156fd426274815b155c83732c59"
PKG_LICENSE="GPL"
PKG_SITE="http://www.linux-usb.org/"
PKG_URL="https://github.com/GNOME/libgudev/archive/refs/tags/${PKG_VERSION}.zip"
PKG_DEPENDS_TARGET="toolchain systemd"


post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/lib/pkgconfig
  rm -rf ${INSTALL}/usr/include
}
