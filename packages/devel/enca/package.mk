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

PKG_NAME="enca"
PKG_VERSION="1.14"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://freshmeat.net/projects/enca/"
PKG_URL="http://dl.cihar.com/enca/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS=""
PKG_BUILD_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="devel"
PKG_SHORTDESC="enca: detects the encoding of text files, on the basis of knowledge of their language."
PKG_LONGDESC="Enca detects the encoding of text files, on the basis of knowledge of their language. It can also convert them to other encodings, allowing you to recode files without knowing their current encoding. It supports most of Central and East European languages, and a few Unicode variants, independently on language."

PKG_IS_ADDON="no"
PKG_AUTORECONF="yes"

export CFLAGS="$CFLAGS -fPIC -DPIC"

PKG_MAKEINSTALL_OPTS_TARGET="-C lib"
PKG_CONFIGURE_OPTS_TARGET="ac_cv_file__dev_random=yes \
                           ac_cv_file__dev_urandom=no \
                           ac_cv_file__dev_srandom=no \
                           ac_cv_file__dev_arandom=no \
                           CPPFLAGS="-I$SYSROOT_PREFIX/usr/include" \
                           --disable-shared \
                           --enable-static \
                           --disable-external \
                           --without-librecode \
                           --disable-rpath \
                           --with-gnu-ld"

pre_make_target() {
  make CC="$HOST_CC" \
       CPPFLAGS="$HOST_CPPFLAGS" \
       CFLAGS="$HOST_CFLAGS" \
       LDFLAGS="$HOST_LDFLAGS" \
       -C tools
}

post_makeinstall_target() {
  mkdir -p $SYSROOT_PREFIX/usr/lib/pkgconfig
    cp enca.pc $SYSROOT_PREFIX/usr/lib/pkgconfig
}
