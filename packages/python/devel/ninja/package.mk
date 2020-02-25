# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ninja"
PKG_VERSION="1.10.0"
PKG_SHA256="3810318b08489435f8efc19c05525e80a993af5a55baa0dfeae0465a9d45f99f"
PKG_LICENSE="Apache"
PKG_SITE="http://martine.github.io/ninja/"
PKG_URL="https://github.com/ninja-build/ninja/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python3:host"
PKG_LONGDESC="Small build system with a focus on speed"
PKG_TOOLCHAIN="cmake-make"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp ninja $TOOLCHAIN/bin
}
