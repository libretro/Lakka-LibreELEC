# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="digital_devices"
PKG_VERSION="03ce6c980c437b9545f1c0f609425424dd0c7f71"
PKG_SHA256="6189d7833cd6bfa3a7a6b432bd4e8aea462b970eb32eabf0a4ac1cbf087bdde6"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/DigitalDevices/dddvb/"
PKG_URL="https://github.com/DigitalDevices/dddvb/archive/${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="dddvb-${PKG_VERSION}*"
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
