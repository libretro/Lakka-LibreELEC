# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="m4"
PKG_VERSION="1.4.18"
PKG_SHA256="6640d76b043bc658139c8903e293d5978309bf0f408107146505eca701e67cf6"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/m4/"
PKG_URL="http://ftpmirror.gnu.org/m4/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="ccache:host"
PKG_SECTION="devel"
PKG_SHORTDESC="m4: The m4 macro processor"
PKG_LONGDESC="GNU 'M4' is an implementation of the traditional Unix macro processor. It is mostly SVR4 compatible, although it has some extensions (for example, handling more than 9 positional parameters to macros). 'M4' also has built-in functions for including files, running shell commands, doing arithmetic, etc. Autoconf needs GNU 'M4' for generating 'configure' scripts, but not for running them."

PKG_CONFIGURE_OPTS_HOST="gl_cv_func_gettimeofday_clobber=no --target=$TARGET_NAME"

post_makeinstall_host() {
  make prefix=$SYSROOT_PREFIX/usr install
}
