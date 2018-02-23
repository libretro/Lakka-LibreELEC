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

PKG_NAME="tiff"
#PKG_VERSION="4.0.3"
PKG_VERSION="3.9.7"
PKG_SHA256="f5d64dd4ce61c55f5e9f6dc3920fbe5a41e02c2e607da7117a35eb5c320cef6a"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://www.remotesensing.org/libtiff/"
PKG_URL="http://download.osgeo.org/libtiff/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libjpeg-turbo zlib"
PKG_SECTION="graphics"
PKG_SHORTDESC="libtiff: A library for reading and writing TIFF files"
PKG_LONGDESC="libtiff is a library for reading and writing data files encoded with the Tag Image File format, Revision 6.0 (or revision 5.0 or revision 4.0). This file format is suit- able for archiving multi-color and monochromatic image data."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static \
                           --disable-shared \
                           --disable-mdi \
                           --enable-cxx \
                           --with-gl=no \
                           --with-jpeg-lib-dir=$SYSROOT_PREFIX/usr/lib \
                           --with-jpeg-include-dir=$SYSROOT_PREFIX/usr/include \
                           --without-x \
                           --with-gl=no"

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
}
