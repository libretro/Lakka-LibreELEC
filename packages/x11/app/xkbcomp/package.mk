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

PKG_NAME="xkbcomp"
PKG_VERSION="1.4.0"
PKG_SHA256="bc69c8748c03c5ad9afdc8dff9db11994dd871b614c65f8940516da6bf61ce6b"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/app/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libX11"
PKG_SECTION="x11/app"
PKG_SHORTDESC="xkbcomp: Compiles XKB keyboard description"
PKG_LONGDESC="The xkbcomp keymap compiler converts a description of an XKB keymap into one of several output formats."
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--with-xkb-config-root=$XORG_PATH_XKB"
