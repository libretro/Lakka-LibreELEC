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

PKG_NAME="jasper"
PKG_VERSION="1.900.1"
PKG_SHA256="6e9a959bf4f8cb02f77f42d1b9880b8e85d021ac51f43d8787b5438fd2b7a1c5"
PKG_ARCH="any"
PKG_LICENSE="OpenSource"
PKG_SITE="http://www.ece.uvic.ca/~mdadams/jasper/"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain libjpeg-turbo"
PKG_SECTION="graphics"
PKG_SHORTDESC="jasper: JPEG-2000 Part-1 standard (i.e., ISO/IEC 15444-1) implementation"
PKG_LONGDESC="This distribution contains the public release of the an open-source implementation of the ISO/IEC 15444-1 also known as JPEG-2000 standard for image compression."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared --enable-static"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
