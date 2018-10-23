# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="newt"
PKG_VERSION="0.52.20"
PKG_SHA256="8d66ba6beffc3f786d4ccfee9d2b43d93484680ef8db9397a4fb70b5adbb6dbc"
PKG_LICENSE="GPL"
PKG_SITE="https://pagure.io/newt"
PKG_URL="https://releases.pagure.org/newt/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain slang popt"
PKG_LONGDESC="Newt is a programming library for color text mode, widget based user interfaces."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-nls \
                           --without-python \
                           --without-tcl"

pre_configure_target() {
 # newt fails to build in subdirs
 cd $PKG_BUILD
 rm -rf .$TARGET_NAME
}

pre_configure_host() {
 # newt fails to build in subdirs
 cd $PKG_BUILD
 rm -rf .$HOST_NAME
}
