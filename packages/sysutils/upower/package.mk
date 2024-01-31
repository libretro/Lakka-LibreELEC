# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="upower"
PKG_VERSION="v1.90.0"
PKG_SHA256="cb6028f095824422c59d98b3c9903e2eda2a96fc613f11824f0b6379de7efa2e"
PKG_LICENSE="GPL"
PKG_SITE="http://www.linux-usb.org/"
PKG_URL="https://gitlab.freedesktop.org/upower/upower/-/archive/${PKG_VERSION}/upower-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd glib dbus libusb libgudev"
PKG_LONGDESC="Upower is a modular hardware abstraction layer designed for use in Linux systems that is designed to simplify device management and replace the current monolithic Linux HAL. Upower includes the ability to enumerate system devices and send notifications when hardware is added or removed from the computer system."

PKG_MESON_OPTS_TARGET="-Dgtk-doc=false -Dman=false"

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/lib/pkgconfig
  rm -rf ${INSTALL}/usr/include
}

post_install() {
  enable_service upower.service
}
