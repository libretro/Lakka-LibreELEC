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

PKG_NAME="libxcb"
PKG_VERSION="1.12"
PKG_SHA256="4adfb1b7c67e99bc9c2ccb110b2f175686576d2f792c8a71b9c8b19014057b5b"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="http://xcb.freedesktop.org"
PKG_URL="http://xcb.freedesktop.org/dist/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain util-macros Python2:host xcb-proto libpthread-stubs libXau"
PKG_SECTION="x11/lib"
PKG_SHORTDESC="libxcb: X C-language Bindings library"
PKG_LONGDESC="X C-language Bindings library."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared \
                           --disable-screensaver \
                           --disable-xprint \
                           --disable-selinux \
                           --disable-xvmc"

pre_configure_target() {
  PYTHON_LIBDIR=$SYSROOT_PREFIX/usr/lib/$PKG_PYTHON_VERSION
  PYTHON_TOOLCHAIN_PATH=$PYTHON_LIBDIR/site-packages

  PKG_CONFIG="$PKG_CONFIG --define-variable=pythondir=$PYTHON_TOOLCHAIN_PATH"
  PKG_CONFIG="$PKG_CONFIG --define-variable=xcbincludedir=$SYSROOT_PREFIX/usr/share/xcb"
}
