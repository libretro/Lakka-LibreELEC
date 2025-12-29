# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

# with 1.0.0 repeat delay is broken. test on upgrade

PKG_NAME="duktape"
PKG_VERSION="2.7.0"
PKG_LICENSE="GPL"
PKG_SHA256="90f8d2fa8b5567c6899830ddef2c03f3c27960b11aca222fa17aa7ac613c2890"
PKG_SITE="https://github.com/svaarala/duktape"
PKG_URL="https://duktape.org/duktape-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC=""

post_install () {
  rm -rf ${INSTALL}/usr/include
}
