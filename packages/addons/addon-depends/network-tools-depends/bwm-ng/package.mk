################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="bwm-ng"
PKG_VERSION="0.6.1"
PKG_SHA256="613e8072b0efc2f5f790143192bca45c3c80b7ad09bff384de9bbaa57aa499b8"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gropp.org/?id=projects&sub=bwm-ng"
PKG_URL="https://github.com/vgropp/bwm-ng/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain ncurses libstatgrab"
PKG_SECTION="network/analyzer"
PKG_SHORTDESC="bwm-ng: small and simple console-based live network and disk io bandwidth monitor"
PKG_LONGDESC="Bandwidth Monitor NG is a small and simple console-based live network and disk io bandwidth monitor for Linux, BSD, Solaris, Mac OS X and others."
PKG_AUTORECONF="yes"

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
