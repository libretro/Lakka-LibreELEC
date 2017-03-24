################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gropp.org/?id=projects&sub=bwm-ng"
PKG_URL="http://www.gropp.org/bwm-ng/bwm-ng-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain netbsd-curses libstatgrab"
PKG_SECTION="network/analyzer"
PKG_SHORTDESC="bwm-ng: small and simple console-based live network and disk io bandwidth monitor"
PKG_LONGDESC="Bandwidth Monitor NG is a small and simple console-based live network and disk io bandwidth monitor for Linux, BSD, Solaris, Mac OS X and others."
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--with-libstatgrab \
                           --with-time \
                           --with-getifaddrs \
                           --with-sysctl \
                           --with-sysctldisk \
                           --with-procnetdev \
                           --with-partitions"

pre_configure_target() {
  export LIBS="-ltermcap"
}

makeinstall_target() {
  : # nop
}
