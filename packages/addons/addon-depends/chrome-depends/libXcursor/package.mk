################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="libXcursor"
PKG_VERSION="1.1.15"
PKG_SHA256="294e670dd37cd23995e69aae626629d4a2dfe5708851bbc13d032401b7a3df6b"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/lib/libXcursor-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libX11 libXfixes libXrender"
PKG_LONGDESC="X11 Cursor management library"
PKG_BUILD_FLAGS="+pic"
