# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="digital_devices"
PKG_VERSION="21aefddd4bbff5ac2915cfde05bd5d373ce413c3"
PKG_SHA256="0ef1e9c2edd9c574c67b30f2e5d79d21e95169ed08968704cf25cd77d885da58"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/DigitalDevices/dddvb/"
PKG_URL="https://github.com/DigitalDevices/dddvb/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_BUILD_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_SECTION="driver.dvb"
PKG_LONGDESC="DVB driver for Digital Devices cards"

PKG_IS_ADDON="embedded"
PKG_ADDON_IS_STANDALONE="yes"
PKG_ADDON_NAME="DVB drivers for DigitalDevices"
PKG_ADDON_TYPE="xbmc.service"
PKG_ADDON_VERSION="${ADDON_VERSION}.${PKG_REV}"

make_target() {
  KDIR=$(kernel_path) make
}

makeinstall_target() {
  install_driver_addon_files "$PKG_BUILD/ddbridge $PKG_BUILD/dvb-core $PKG_BUILD/frontends"
}
