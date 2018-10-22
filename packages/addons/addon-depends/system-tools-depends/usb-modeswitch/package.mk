# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="usb-modeswitch"
PKG_VERSION="2.3.0"
PKG_SHA256="f93e940c2eb0c585a5d2210177338e68a9b24f409e351e4a854132453246b894"
PKG_LICENSE="GPL"
PKG_SITE="http://www.draisberghof.de/usb_modeswitch/"
PKG_URL="http://www.draisberghof.de/usb_modeswitch/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_LONGDESC="USB_ModeSwitch - Handling Mode-Switching USB Devices on Linux"

makeinstall_target() {
  : # nop
}
