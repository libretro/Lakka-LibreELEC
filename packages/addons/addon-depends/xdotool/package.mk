################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2015 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="xdotool"
PKG_VERSION="08c8e2d6cad60a69ce415499e34865157a1b66fd"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jordansissel/xdotool"
PKG_URL="$PKG_SITE/archive/$PKG_VERSION.zip"
PKG_DEPENDS_TARGET="toolchain libXinerama libXtst"
PKG_SECTION="x11/app"
PKG_SHORTDESC="This tool lets you simulate keyboard input and mouse activity, move and resize windows, etc."
PKG_LONGDESC="This tool lets you simulate keyboard input and mouse activity, move and resize windows, etc."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  LDFLAGS="$LDFLAGS -lXext"
}

make_target() {
  make xdotool.static
  mv xdotool.static xdotool
}

post_makeinstall_target() {
  mv $INSTALL/usr/local/* $INSTALL/usr/
  rm -rf $INSTALL/usr/local/
}
