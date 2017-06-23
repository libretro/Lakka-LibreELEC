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

PKG_NAME="szap-s2"
PKG_VERSION="69ff358"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://bitbucket.org/updatelee/tune-s2"
PKG_URL="https://bitbucket.org/CrazyCat/szap-s2/get/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="CrazyCat-${PKG_NAME}-${PKG_VERSION}*"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="szap-s2 is a simple zapping tool for the Linux DVB S2 API"
PKG_LONGDESC="szap-s2 is a simple zapping tool for the Linux DVB S2 API"
PKG_AUTORECONF="no"

makeinstall_target() {
  :
}
