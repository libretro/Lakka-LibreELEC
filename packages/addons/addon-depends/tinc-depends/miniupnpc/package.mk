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

PKG_NAME="miniupnpc"
PKG_VERSION="2.0.20180222"
PKG_SHA256="587944686469d09f739744b3aed70c7ce753a79c40d6f1227f68a3e962665b75"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://miniupnp.free.fr"
PKG_URL="http://miniupnp.free.fr/files/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The MiniUPnP project offers software which supports the UPnP Internet Gateway Device (IGD) specifications"

PKG_CMAKE_OPTS_TARGET="-DUPNPC_BUILD_SHARED=OFF -DUPNPC_BUILD_STATIC=ON"
