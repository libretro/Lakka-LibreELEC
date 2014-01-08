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

PKG_NAME="expat"
PKG_VERSION="2.1.0"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://expat.sourceforge.net/"
PKG_URL="$SOURCEFORGE_SRC/$PKG_NAME/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_HOST="ccache:host autotools"
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="textproc"
PKG_SHORTDESC="expat: XML parser library"
PKG_LONGDESC="Expat is an XML parser library written in C. It is a stream-oriented parser in which an application registers handlers for things the parser might find in the XML document (like start tags). An introductory article on using Expat is available on xml.com."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

pre_configure_target() {
  ( cd ..; do_autoreconf -I conftools)
}

pre_configure_host() {
  ( cd ..; do_autoreconf -I conftools)
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}

