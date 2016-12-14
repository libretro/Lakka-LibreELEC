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

PKG_NAME="xkeyboard-config"
PKG_VERSION="2.19"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://www.x.org/releases/individual/data/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros xkbcomp"
PKG_SECTION="x11/data"
PKG_SHORTDESC="xkeyboard-config: X keyboard extension data files"
PKG_LONGDESC="X keyboard extension data files."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

PKG_CONFIGURE_OPTS_TARGET="XKBCOMP=/usr/bin/xkbcomp \
                           --without-xsltproc \
                           --enable-compat-rules \
                           --enable-runtime-deps \
                           --enable-nls \
                           --disable-rpath \
                           --with-xkb-base=$XORG_PATH_XKB \
                           --with-xkb-rules-symlink=xorg \
                           --with-gnu-ld"

pre_build_target() {
# broken autoreconf
  ( cd $PKG_BUILD
    intltoolize --force
  )
}
