# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bwm-ng"
PKG_VERSION="0.6.1"
PKG_SHA256="613e8072b0efc2f5f790143192bca45c3c80b7ad09bff384de9bbaa57aa499b8"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gropp.org/?id=projects&sub=bwm-ng"
PKG_URL="https://github.com/vgropp/bwm-ng/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses libstatgrab"
PKG_LONGDESC="A small and simple console-based live network and disk io bandwidth monitor."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--with-libstatgrab \
                           --with-time \
                           --with-getifaddrs \
                           --with-sysctl \
                           --with-sysctldisk \
                           --with-procnetdev \
                           --with-partitions"

makeinstall_target() {
  : # nop
}
