# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="sed"
PKG_VERSION="4.2.2"
PKG_SHA256="f048d1838da284c8bc9753e4506b85a1e0cc1ea8999d36f6995bcb9460cddbd7"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/sed/"
PKG_URL="http://ftpmirror.gnu.org/sed/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="ccache:host"
PKG_SECTION="sysutils"
PKG_SHORTDESC="sed: This is the GNU implementation of the POSIX stream editor"
PKG_LONGDESC="The sed (Stream EDitor) editor is a stream or batch (non-interactive) editor. Sed takes text as input, performs an operation or set of operations on the text and outputs the modified text. The operations that sed performs (substitutions, deletions, insertions, etc.) can be specified in a script file or from the command line."

PKG_CONFIGURE_OPTS_HOST="--disable-nls --disable-acl --without-selinux"
PKG_MAKEINSTALL_OPTS_HOST="-C sed install"
