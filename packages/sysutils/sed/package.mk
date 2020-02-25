# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="sed"
PKG_VERSION="4.8"
PKG_SHA256="f79b0cfea71b37a8eeec8490db6c5f7ae7719c35587f21edb0617f370eeff633"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/sed/"
PKG_URL="http://ftpmirror.gnu.org/sed/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="The sed (Stream EDitor) editor is a stream or batch (non-interactive) editor."

PKG_CONFIGURE_OPTS_HOST="--disable-nls --disable-acl --without-selinux"
