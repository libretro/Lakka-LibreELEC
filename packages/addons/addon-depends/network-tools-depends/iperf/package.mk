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

PKG_NAME="iperf"
PKG_VERSION="3.1.2"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://iperf.fr/"
PKG_URL="https://iperf.fr/download/source/$PKG_NAME-$PKG_VERSION-source.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="network/testing"
PKG_SHORTDESC="iperf: A modern alternative for measuring maximum TCP and UDP bandwidth performance"
PKG_LONGDESC="Iperf was developed by NLANR/DAST as a modern alternative for measuring maximum TCP and UDP bandwidth performance. Iperf allows the tuning of various parameters and UDP characteristics. Iperf reports bandwidth, delay jitter, datagram loss."
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"

makeinstall_target() {
  : # nop
}
