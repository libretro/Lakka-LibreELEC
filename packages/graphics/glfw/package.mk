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

PKG_NAME="glfw"
PKG_VERSION="2.7.9"
PKG_REV="1"
PKG_ARCH="x86_64"
PKG_LICENSE="BSD"
PKG_SITE="http://glfw.org"
PKG_URL="$SOURCEFORGE_SRC/glfw/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain mesa glu"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="glfw:"
PKG_LONGDESC="glfw:"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi

make_target() {
  make x11 PREFIX=$SYSROOT_PREFIX/usr
}

makeinstall_target() {
  make x11-install PREFIX=$SYSROOT_PREFIX/usr
}
