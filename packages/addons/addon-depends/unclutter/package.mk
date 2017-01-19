################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
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

PKG_NAME="unclutter"
PKG_VERSION="1.09"
PKG_ARCH="any"
PKG_LICENSE="Public Domain"
PKG_SITE="https://sourceforge.net/projects/unclutter/"
PKG_URL="http://jaist.dl.sourceforge.net/project/unclutter/unclutter/source_$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libX11"
PKG_SECTION="x11"
PKG_SHORTDESC="Unclutter: Hide X11 Cursor"
PKG_LONGDESC="Unclutter runs in the background of an X11 session and after a specified period of inactivity hides the cursor from display. When the cursor is moved its display is restored. Users may specify specific windows to be ignored by unclutter."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  rm -f Makefile
  LDFLAGS="$LDFLAGS -lX11" $MAKE unclutter
}

makeinstall_target() {
  mkdir -p .install_pkg/usr/bin
  install -m 755 unclutter .install_pkg/usr/bin/
}
