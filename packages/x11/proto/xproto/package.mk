################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="xproto"
PKG_VERSION="7.0.31"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.x.org/"
PKG_URL="http://xorg.freedesktop.org/archive/individual/proto/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="util-macros"
PKG_DEPENDS_TARGET="toolchain util-macros"
PKG_SECTION="x11/proto"
PKG_SHORTDESC="xproto: KB extension headers"
PKG_LONGDESC="X11 extension headers"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# package specific configure options
PKG_CONFIGURE_OPTS_TARGET="--without-xmlto"
PKG_CONFIGURE_OPTS_HOST="--without-xmlto"
