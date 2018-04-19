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

PKG_NAME="tcpdump"
PKG_VERSION="4.9.2"
PKG_SHA256="798b3536a29832ce0cbb07fafb1ce5097c95e308a6f592d14052e1ef1505fe79"
PKG_ARCH="any"
PKG_SITE="http://www.tcpdump.org/"
PKG_URL="http://www.tcpdump.org/release/tcpdump-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libpcap"
PKG_SECTION="network/analyzer"
PKG_SHORTDESC="powerful tool for network monitoring and data acquisition"
PKG_LONGDESC="This program allows you to dump the traffic on a network."

PKG_CONFIGURE_OPTS_TARGET="--with-crypto=no"

pre_configure_target() {
  # When cross-compiling, configure can't set linux version
  # forcing it
  sed -i -e 's/ac_cv_linux_vers=unknown/ac_cv_linux_vers=2/' ../configure
}

pre_build_target() {
  # discard native system includes
  sed -i "s%-I/usr/include%%g" Makefile
}

makeinstall_target() {
  :
}
