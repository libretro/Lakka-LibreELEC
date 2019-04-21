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

PKG_NAME="fontconfig"
PKG_VERSION="2.13.1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.fontconfig.org"
PKG_URL="http://www.freedesktop.org/software/fontconfig/release/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain util-macros freetype libxml2 zlib expat"
PKG_SECTION="x11/other"
PKG_SHORTDESC="fontconfig: A library for font customization and configuration"
PKG_LONGDESC="Fontconfig is a library for font customization and configuration."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--with-arch=$TARGET_ARCH \
                           --with-cache-dir=/storage/.cache/fontconfig \
                           --with-default-fonts=/usr/share/fonts \
                           --without-add-fonts \
                           --disable-dependency-tracking \
                           --disable-docs"

pre_configure_target() {
# ensure we dont use '-O3' optimization.
  CFLAGS=`echo $CFLAGS | sed -e "s|-O3|-O2|"`
  CXXFLAGS=`echo $CXXFLAGS | sed -e "s|-O3|-O2|"`
  CFLAGS="$CFLAGS -I$PKG_BUILD"
  CXXFLAGS="$CXXFLAGS -I$PKG_BUILD"
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
