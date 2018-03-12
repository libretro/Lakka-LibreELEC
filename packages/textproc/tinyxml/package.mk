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

PKG_NAME="tinyxml"
PKG_VERSION="2.6.2_2"
PKG_SHA256="8164c9ad48b9028667768a584d62f7760cfbfb90d0dd6214ad174403058da10c"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.grinninglizard.com/tinyxml/"
PKG_URL="http://mirrors.xbmc.org/build-deps/sources/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="textproc"
PKG_SHORTDESC="tinyxml: XML parser library"
PKG_LONGDESC="TinyXML is a simple, small, C++ XML parser that can be easily integrating into other programs."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --with-pic"

post_makeinstall_target() {
  rm -rf $INSTALL/usr
}
