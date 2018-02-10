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

PKG_NAME="autoconf-archive"
PKG_VERSION="2017.09.28"
PKG_SHA256="5c9fb5845b38b28982a3ef12836f76b35f46799ef4a2e46b48e2bd3c6182fa01"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.gnu.org/software/autoconf-archive/"
PKG_URL="http://ftpmirror.gnu.org/autoconf-archive/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="autoconf-archive: macros for autoconf"
PKG_LONGDESC="autoconf-archive is an package of m4 macros"

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME --prefix=$TOOLCHAIN"

makeinstall_host() {
# make install
  make prefix=$SYSROOT_PREFIX/usr install

# remove problematic m4 file
  rm -rf $SYSROOT_PREFIX/usr/share/aclocal/ax_prog_cc_for_build.m4
}
