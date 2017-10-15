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

PKG_NAME="xrandr"
PKG_VERSION="1.5.0"
PKG_SHA256="c1cfd4e1d4d708c031d60801e527abc9b6d34b85f2ffa2cadd21f75ff38151cd"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/app/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros libXrandr"
PKG_SECTION="x11/app"
PKG_SHORTDESC="xrandr: A primitive command line interface to RandR extension"
PKG_LONGDESC="Xrandr is a primitive command line interface to the RandR extension and used to set the screen size, orientation and/or reflection."
PKG_AUTORECONF="no"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin/xkeystone
}
