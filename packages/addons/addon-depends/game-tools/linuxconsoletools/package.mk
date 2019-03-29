# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="linuxconsoletools"
PKG_VERSION="1.5.1"
PKG_SHA256="0bd07aacea251d63d3d8a458728c7f965f41ae45891d906cefedc3fde0753b1e"
PKG_LICENSE="GPL"
PKG_SITE="http://sourceforge.net/projects/linuxconsole/"
PKG_URL="http://prdownloads.sourceforge.net/linuxconsole/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Set of utilities for joysticks and serial devices."

PKG_MAKE_OPTS_TARGET="SYSTEMD_SUPPORT=0"

makeinstall_target() {
  :
}
