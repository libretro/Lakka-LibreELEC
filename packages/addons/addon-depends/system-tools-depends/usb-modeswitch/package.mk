# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="usb-modeswitch"
PKG_VERSION="2.5.2"
PKG_SHA256="abffac09c87eacd78e101545967dc25af7e989745b4276756d45dbf4008a2ea6"
PKG_LICENSE="GPL"
PKG_SITE="http://www.draisberghof.de/usb_modeswitch/"
PKG_URL="http://www.draisberghof.de/usb_modeswitch/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_LONGDESC="USB_ModeSwitch - Handling Mode-Switching USB Devices on Linux"

makeinstall_target() {
  :
}
