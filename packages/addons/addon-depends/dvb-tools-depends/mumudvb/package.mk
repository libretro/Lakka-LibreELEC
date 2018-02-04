################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

PKG_NAME="mumudvb"
PKG_VERSION="a09373d"
PKG_SHA256="66ef8f11a0e5795cd6408e33581a95de88a76d499e8a0d41f34880295d346efa"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://mumudvb.net/"
PKG_URL="https://github.com/braice/MuMuDVB/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="MuMuDVB-${PKG_VERSION}*"
PKG_DEPENDS_TARGET="toolchain libdvbcsa"
PKG_SECTION="tools"
PKG_SHORTDESC="MuMuDVB (Multi Multicast DVB) is a program that streams from DVB on a network using multicasting or unicast"
PKG_LONGDESC="MuMuDVB (Multi Multicast DVB) is a program that streams from DVB on a network using multicasting or unicast"
PKG_TOOLCHAIN="autotools"

makeinstall_target() {
  :
}
