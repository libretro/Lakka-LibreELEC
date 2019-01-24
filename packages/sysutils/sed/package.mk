# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="sed"
PKG_VERSION="4.7"
PKG_SHA256="2885768cd0a29ff8d58a6280a270ff161f6a3deb5690b2be6c49f46d4c67bd6a"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/sed/"
PKG_URL="http://ftpmirror.gnu.org/sed/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="The sed (Stream EDitor) editor is a stream or batch (non-interactive) editor."

PKG_CONFIGURE_OPTS_HOST="--disable-nls --disable-acl --without-selinux"
