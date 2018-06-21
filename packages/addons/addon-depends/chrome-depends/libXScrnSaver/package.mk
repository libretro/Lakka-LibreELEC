################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="libXScrnSaver"
PKG_VERSION="1.2.2"
PKG_SHA256="8ff1efa7341c7f34bcf9b17c89648d6325ddaae22e3904e091794e0b4426ce1d"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://xorg.freedesktop.org/"
PKG_URL="https://xorg.freedesktop.org/releases/individual/lib/libXScrnSaver-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain scrnsaverproto"
PKG_LONGDESC="X11 Screen Saver extension client library"

PKG_CONFIGURE_OPTS_TARGET="--disable-static \
                           --enable-shared \
                           --enable-malloc0returnsnull"
