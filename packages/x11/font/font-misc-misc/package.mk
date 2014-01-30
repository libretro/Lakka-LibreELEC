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

PKG_NAME="font-misc-misc"
PKG_VERSION="1.1.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xorg.freedesktop.org/archive/individual/font/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros font-util font-cursor-misc"
PKG_PRIORITY="optional"
PKG_SECTION="x11/font"
PKG_SHORTDESC="font-misc-misc: A misc. public domain font"
PKG_LONGDESC="A misc. public domain font."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="--with-fontrootdir=/usr/share/fonts \
                           --disable-silent-rules \
                           --enable-iso8859-1 \
                           --enable-iso8859-2 \
                           --disable-iso8859-3 \
                           --disable-iso8859-4 \
                           --enable-iso8859-5 \
                           --disable-iso8859-6 \
                           --enable-iso8859-7 \
                           --enable-iso8859-8 \
                           --enable-iso8859-9 \
                           --disable-iso8859-10 \
                           --disable-iso8859-11 \
                           --disable-iso8859-12 \
                           --disable-iso8859-13 \
                           --enable-iso8859-14 \
                           --enable-iso8859-15 \
                           --disable-iso8859-16 \
                           --disable-koi8-r \
                           --disable-jisx0201"

PKG_MAKE_OPTS_TARGET="UTIL_DIR=$SYSROOT_PREFIX/usr/share/fonts/util/"

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/fonts/misc
    cp 6x13-ISO8859-1.pcf.gz $INSTALL/usr/share/fonts/misc
}

post_install() {
  mkfontdir $INSTALL/usr/share/fonts/misc
  mkfontscale $INSTALL/usr/share/fonts/misc
}
