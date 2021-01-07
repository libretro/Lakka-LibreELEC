# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="linuxconsoletools"
PKG_VERSION="1.7.0"
PKG_SHA256="95d112f06393806116341d593bda002c8bc44119c1538407623268fed90d8c34"
PKG_LICENSE="GPL"
PKG_SITE="http://sourceforge.net/projects/linuxconsole/"
PKG_URL="http://prdownloads.sourceforge.net/linuxconsole/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Set of utilities for joysticks and serial devices."
PKG_BUILD_FLAGS="-sysroot"

PKG_MAKE_OPTS_TARGET="SYSTEMD_SUPPORT=0"

makeinstall_target() {
  make install PREFIX="/usr" DESTDIR="$INSTALL"
}
