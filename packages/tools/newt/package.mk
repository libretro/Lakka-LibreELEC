# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="newt"
PKG_VERSION="0.52.22"
PKG_SHA256="a15efa37e86610b68a942b19a138b44ccb501c234e4c82dab2f5a9b19f7c9e79"
PKG_LICENSE="GPL"
PKG_SITE="https://pagure.io/newt"
PKG_URL="https://releases.pagure.org/newt/${PKG_NAME}-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain slang popt"
PKG_LONGDESC="Newt is a programming library for color text mode, widget based user interfaces."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-nls \
                           --without-python \
                           --without-tcl"

pre_configure_target() {
 # newt fails to build in subdirs
 cd ${PKG_BUILD}
 rm -rf .${TARGET_NAME}
}

pre_configure_host() {
 # newt fails to build in subdirs
 cd ${PKG_BUILD}
 rm -rf .${HOST_NAME}
}
