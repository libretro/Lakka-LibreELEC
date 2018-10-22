# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="autoconf-archive"
PKG_VERSION="2017.09.28"
PKG_SHA256="5c9fb5845b38b28982a3ef12836f76b35f46799ef4a2e46b48e2bd3c6182fa01"
PKG_LICENSE="GPL"
PKG_SITE="https://www.gnu.org/software/autoconf-archive/"
PKG_URL="http://ftpmirror.gnu.org/autoconf-archive/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="autoconf-archive is an package of m4 macros"

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME --prefix=$TOOLCHAIN"

makeinstall_host() {
# make install
  make prefix=$SYSROOT_PREFIX/usr install

# remove problematic m4 file
  rm -rf $SYSROOT_PREFIX/usr/share/aclocal/ax_prog_cc_for_build.m4
}
