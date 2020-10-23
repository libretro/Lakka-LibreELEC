# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ninja"
PKG_VERSION="1.9.0"
PKG_SHA256="5d7ec75828f8d3fd1a0c2f31b5b0cea780cdfe1031359228c428c1a48bfcd5b9"
PKG_LICENSE="Apache"
PKG_SITE="http://martine.github.io/ninja/"
PKG_URL="https://github.com/ninja-build/ninja/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python2:host"
PKG_LONGDESC="Small build system with a focus on speed"
PKG_TOOLCHAIN="manual"

make_host() {
  python2 configure.py --bootstrap
}

makeinstall_host() {
  cp ninja $TOOLCHAIN/bin/
}
