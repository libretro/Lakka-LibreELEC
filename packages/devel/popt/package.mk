# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="popt"
PKG_VERSION="1.16"
PKG_SHA256="e728ed296fe9f069a0e005003c3d6b2dde3d9cad453422a10d6558616d304cc8"
PKG_LICENSE="GPL"
PKG_SITE="http://rpm5.org/files/popt/"
PKG_URL="http://rpm5.org/files/popt/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="The popt library exists essentially for parsing command-line options."

pre_configure_target() {
 cd $PKG_BUILD
 rm -rf .$TARGET_NAME
}

pre_configure_host() {
 cd $PKG_BUILD
 rm -rf .$HOST_NAME
}
