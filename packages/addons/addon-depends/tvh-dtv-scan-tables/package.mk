################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="tvh-dtv-scan-tables"
PKG_VERSION="4258e52"
PKG_SHA256="48de5baa843ecd5a2231e9b007fc6b3fd86739ddd075158b31fcdefdcd3ce2dd"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/tvheadend"
PKG_URL="https://github.com/tvheadend/dtv-scan-tables/archive/$PKG_VERSION.tar.gz"
PKG_SOURCE_DIR="dtv-scan-tables-${PKG_VERSION}*"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Digital TV scan tables, a fork from Tvh to support more recent tables"
PKG_TOOLCHAIN="manual"
