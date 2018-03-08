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
PKG_VERSION="2.23.1"
PKG_SHA256="2a4bbc05fea22151b7a7c8ac2655d549aa9b0486bedc7f5a68c72716343b02f3"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://www.x.org/releases/individual/data/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_SECTION="x11/data"
PKG_SHORTDESC="xkeyboard-config: X keyboard extension data files"
PKG_LONGDESC="X keyboard extension data files."
PKG_TOOLCHAIN="autotools"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET="toolchain util-macros xkbcomp"
  DISPLAYSERVER_XKEYBOARD="XKBCOMP=/usr/bin/xkbcomp \
                           --with-xkb-base=$XORG_PATH_XKB \
                           --with-xkb-rules-symlink=xorg"

else
  PKG_DEPENDS_TARGET="toolchain util-macros"
  DISPLAYSERVER_XKEYBOARD=""
fi

PKG_CONFIGURE_OPTS_TARGET="--without-xsltproc \
                           --enable-compat-rules \
                           --disable-runtime-deps \
                           --enable-nls \
                           --disable-rpath \
                           --with-gnu-ld \
                           $DISPLAYSERVER_XKEYBOARD"

pre_build_target() {
# broken autoreconf
  ( cd $PKG_BUILD
    intltoolize --force
  )
}
