# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="automake"
PKG_VERSION="1.15.1"
PKG_SHA256="af6ba39142220687c500f79b4aa2f181d9b24e4f8d8ec497cea4ba26c64bedaf"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://sources.redhat.com/automake/"
PKG_URL="http://ftpmirror.gnu.org/automake/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="ccache:host autoconf:host"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="automake: A GNU tool for automatically creating Makefiles"
PKG_LONGDESC="This is Automake, a Makefile generator. It was inspired by the 4.4BSD make and include files, but aims to be portable and to conform to the GNU standards for Makefile variables and targets. Automake is a Perl script. The input files are called Makefile.am. The output files are called Makefile.in; they are intended for use with Autoconf. Automake requires certain things to be done in your configure.in."

PKG_CONFIGURE_OPTS_HOST="--target=$TARGET_NAME --disable-silent-rules"

post_makeinstall_host() {
  make prefix=$SYSROOT_PREFIX/usr install
}
