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

PKG_NAME="soxr"
PKG_VERSION="0.1.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="LGPL"
PKG_SITE="http://sourceforge.net/p/soxr/wiki/Home/"
PKG_URL="$SOURCEFORGE_SRC/soxr/$PKG_NAME-$PKG_VERSION-Source.tar.xz"
PKG_SOURCE_DIR="$PKG_NAME-$PKG_VERSION-Source"
PKG_DEPENDS_TARGET="toolchain cmake:host"
PKG_PRIORITY="optional"
PKG_SECTION="audio"
PKG_SHORTDESC="soxr: a library which performs one-dimensional sample-rate conversion."
PKG_LONGDESC="The SoX Resampler library performs one-dimensional sample-rate conversion. it may be used, for example, to resample PCM-encoded audio."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

# package specific configure options
configure_target() {
  cmake -DCMAKE_TOOLCHAIN_FILE=$CMAKE_CONF \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DHAVE_WORDS_BIGENDIAN_EXITCODE=1 \
        -DBUILD_TESTS=0 \
        -DBUILD_EXAMPLES=1 \
        -DBUILD_SHARED_LIBS=OFF ..
}

#post_makeinstall_target() {
#  rm -rf $INSTALL/usr/bin
#  # pkgconf hack
#  $SED "s:\(['=\" ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/bin/taglib-config
#  $SED "s:\([':\" ]\)-I/usr:\\1-I$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib.pc
#  $SED "s:\([':\" ]\)-L/usr:\\1-L$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib.pc
#  $SED "s:\([':\" ]\)-I/usr:\\1-I$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib_c.pc
#  $SED "s:\([':\" ]\)-L/usr:\\1-L$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/lib/pkgconfig/taglib_c.pc
#}
