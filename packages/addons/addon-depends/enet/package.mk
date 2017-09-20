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

PKG_NAME="enet"
PKG_VERSION="e33ca1d"
PKG_ARCH="any"
PKG_LICENSE=""
PKG_SITE="https://github.com/cgutman/enet/"
PKG_URL="https://github.com/cgutman/enet/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="network"
PKG_SHORTDESC="ENet's purpose is to provide a relatively thin, simple and robust network communication layer on top of UDP (User Datagram Protocol)"
PKG_LONGDESC="ENet's purpose is to provide a relatively thin, simple and robust network communication layer on top of UDP (User Datagram Protocol)"
PKG_USE_CMAKE="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"

post_makeinstall_target() {
  rm -r $INSTALL
}
