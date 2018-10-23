# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="sed"
PKG_VERSION="4.2.2"
PKG_SHA256="f048d1838da284c8bc9753e4506b85a1e0cc1ea8999d36f6995bcb9460cddbd7"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/sed/"
PKG_URL="http://ftpmirror.gnu.org/sed/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="The sed (Stream EDitor) editor is a stream or batch (non-interactive) editor."

PKG_CONFIGURE_OPTS_HOST="--disable-nls --disable-acl --without-selinux"
PKG_MAKEINSTALL_OPTS_HOST="-C sed install"
