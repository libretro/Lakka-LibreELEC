# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tstools"
PKG_VERSION="db1f79f"
PKG_SHA256="f204229016c9deafcc75fe602c390339878312126134edbfcebf239e093dc4ff"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kynesim/tstools"
PKG_URL="https://github.com/kynesim/tstools/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="This is a set of cross-platform command line tools for working with MPEG data."
PKG_BUILD_FLAGS="-parallel"

make_target() {
  make CROSS_COMPILE=$TARGET_PREFIX
}

makeinstall_target() {
  :
}
