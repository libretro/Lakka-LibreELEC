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

# libepoxy (actually) needs to be built shared, to avoid
# (EE) Failed to load /usr/lib/xorg/modules/libglamoregl.so: 
# /usr/lib/xorg/modules/libglamoregl.so: undefined symbol: epoxy_eglCreateImageKHR
# in Xorg.log

PKG_NAME="libepoxy"
PKG_VERSION="b2ae054"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/anholt/libepoxy"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain Mesa"
PKG_PRIORITY="optional"
PKG_SECTION="graphics"
PKG_SHORTDESC="libepoxy: a library for handling OpenGL function pointer management for you."
PKG_LONGDESC="Epoxy is a library for handling OpenGL function pointer management for you."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

