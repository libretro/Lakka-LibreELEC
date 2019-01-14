# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="strace"
PKG_VERSION="4.26"
PKG_SHA256="7c4d2ffeef4f7d1cdc71062ca78d1130eb52f947c2fca82f59f6a1183bfa1e1c"
PKG_LICENSE="BSD"
PKG_SITE="https://strace.io/"
PKG_URL="https://strace.io/files/$PKG_VERSION/strace-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="strace is a diagnostic, debugging and instructional userspace utility"
PKG_TOOLCHAIN="autotools"

makeinstall_target() {
  :
}
