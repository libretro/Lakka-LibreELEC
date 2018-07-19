# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hid_mapper"
PKG_VERSION="2.1.0"
PKG_SHA256="e740c1f3a99f260f015ea7d415f0419e27171356e2eddff1781fc5d936cc86cd"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/s-leroux/hid_mapper"
PKG_URL="https://github.com/s-leroux/hid_mapper/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="generic HID mapper"
PKG_LONGDESC="generic HID mapper"

makeinstall_target() {
  : # nope
}
