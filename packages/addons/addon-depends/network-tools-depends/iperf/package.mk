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

PKG_NAME="iperf"
PKG_VERSION="3.5"
PKG_SHA256="4c318707a29d46d7b64e517a4fe5e5e75e698aef030c6906e9b26dc51d9b1fce"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://software.es.net/iperf/"
PKG_URL="https://github.com/esnet/iperf/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain openssl"
PKG_SECTION="network/testing"
PKG_SHORTDESC="iperf: A modern alternative for measuring maximum TCP and UDP bandwidth performance"
PKG_LONGDESC="Iperf was developed by NLANR/DAST as a modern alternative for measuring maximum TCP and UDP bandwidth performance."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared"

makeinstall_target() {
  :
}
