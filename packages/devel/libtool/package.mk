################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="libtool"
PKG_VERSION="2.4.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/libtool/libtool.html"
PKG_URL="http://ftp.gnu.org/gnu/libtool/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_HOST="ccache:host autoconf"
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="libtool: Generic library support script"
PKG_LONGDESC="This is GNU Libtool, a generic library support script. Libtool hides the complexity of using shared libraries behind a consistent, portable interface."
PKG_IS_ADDON="no"

PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--enable-ltdl-install"
