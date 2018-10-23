# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="m4"
PKG_VERSION="1.4.18"
PKG_SHA256="6640d76b043bc658139c8903e293d5978309bf0f408107146505eca701e67cf6"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/m4/"
PKG_URL="http://ftpmirror.gnu.org/m4/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="The m4 macro processor."

PKG_CONFIGURE_OPTS_HOST="gl_cv_func_gettimeofday_clobber=no --target=$TARGET_NAME"

post_makeinstall_host() {
  make prefix=$SYSROOT_PREFIX/usr install
}
