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

PKG_NAME="fribidi"
PKG_VERSION="1.0.1"
PKG_SHA256="c1b182d70590b6cdb5545bab8149de33b966800f27f2d9365c68917ed5a174e4"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://fribidi.freedesktop.org/"
PKG_URL="https://github.com/fribidi/fribidi/releases/download/v$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="devel"
PKG_SHORTDESC="fribidi: The Bidirectional Algorithm library"
PKG_LONGDESC="The library implements all of the algorithm as described in the Unicode Standard Annex #9, The Bidirectional Algorithm, http://www.unicode.org/unicode/reports/tr9/. FriBidi is exhautively tested against Bidi Reference Code, and due to our best knowledge, does not contain any conformance bugs."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--disable-shared \
                           --enable-static \
                           --disable-debug \
                           --disable-deprecated \
                           --disable-silent-rules \
                           --enable-malloc \
                           --enable-charsets \
                           --with-gnu-ld \
                           --without-glib"

pre_configure_target() {
  export CFLAGS="$CFLAGS -DFRIBIDI_CHUNK_SIZE=4080"
}

post_makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/bin
    cp -f $PKG_DIR/scripts/fribidi-config $SYSROOT_PREFIX/usr/bin
    chmod +x $SYSROOT_PREFIX/usr/bin/fribidi-config

  rm -rf $INSTALL/usr/bin
}
