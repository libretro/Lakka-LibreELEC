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

PKG_NAME="mergerfs"
PKG_VERSION="2.24.0"
PKG_ARCH="any"
PKG_SITE="https://github.com/trapexit/mergerfs"
PKG_URL="$PKG_SITE/releases/download/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="retroarch toolchain fuse"
PKG_SECTION="tools"
PKG_SHORTDESC="a featureful union filesystem "
PKG_MAKE_OPTS_TARGET="XATTR_AVAILABLE=0"
PKG_MAKEINSTALL_OPTS_TARGET="PREFIX=/usr"