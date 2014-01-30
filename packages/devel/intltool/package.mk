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

PKG_NAME="intltool"
PKG_VERSION="0.50.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnome.org"
PKG_URL="http://launchpad.net/intltool/trunk/$PKG_VERSION/+download/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="intltool: Gnome international tools"
PKG_LONGDESC="The Gnome international tools help to handle translation strings from various source files (.xml.in, .glade, .desktop.in, .server.in, .oaf.in)."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

post_makeinstall_host() {
  mkdir -p  $SYSROOT_PREFIX/usr/share/aclocal
    cp ../intltool.m4 $SYSROOT_PREFIX/usr/share/aclocal
}
