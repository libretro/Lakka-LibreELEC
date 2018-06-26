################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="libxss"
PKG_VERSION="1.2.2"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/lib/libXScrnSaver-$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="libXScrnSaver-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain util-macros libXext scrnsaverproto"
PKG_LONGDESC="X11 Screen Saver extension library"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-malloc0returnsnull"
