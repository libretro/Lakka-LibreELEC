# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="autoconf"
PKG_VERSION="2.69"
PKG_SHA256="64ebcec9f8ac5b2487125a86a7760d2591ac9e1d3dbd59489633f9de62a57684"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://sources.redhat.com/autoconf/"
PKG_URL="http://ftpmirror.gnu.org/autoconf/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="ccache:host m4:host gettext:host"
PKG_SECTION="toolchain/devel"
PKG_SHORTDESC="autoconf: A GNU tool for automatically configuring source code"
PKG_LONGDESC="Autoconf is an extensible package of m4 macros that produce shell scripts to automatically configure software source code packages. These scripts can adapt the packages to many kinds of UNIX-like systems without manual user intervention. Autoconf creates a configuration script for a package from a template file that lists the operating system features that the package can use, in the form of m4 macro calls."

PKG_CONFIGURE_OPTS_HOST="EMACS=no \
                         ac_cv_path_M4=$TOOLCHAIN/bin/m4 \
                         ac_cv_prog_gnu_m4_gnu=no \
                         --target=$TARGET_NAME"

post_makeinstall_host() {
  make prefix=$SYSROOT_PREFIX/usr install
}
