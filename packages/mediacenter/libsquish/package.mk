################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2014 Stefan Saraev (stefan@sarae.va)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="libsquish"
PKG_VERSION="1.10-openelec"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION=""
PKG_SHORTDESC="libsquish"
PKG_LONGDESC="libsquish"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_MAKE_OPTS_TARGET="PREFIX=/usr INSTALL_DIR=$SYSROOT_PREFIX/usr"
PKG_MAKEINSTALL_OPTS_TARGET="$PKG_MAKE_OPTS_TARGET"
