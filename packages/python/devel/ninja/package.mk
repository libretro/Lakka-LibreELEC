# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ninja"
PKG_VERSION="1.10.1"
PKG_SHA256="a6b6f7ac360d4aabd54e299cc1d8fa7b234cd81b9401693da21221c62569a23e"
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
