# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ninja"
PKG_VERSION="1.12.1"
PKG_SHA256="821bdff48a3f683bc4bb3b6f0b5fe7b2d647cf65d52aeb63328c91a6c6df285a"
PKG_LICENSE="Apache"
PKG_SITE="https://ninja-build.org/"
PKG_URL="https://github.com/ninja-build/ninja/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host googletest:host"
PKG_LONGDESC="Small build system with a focus on speed"
PKG_TOOLCHAIN="cmake-make"

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
    cp ninja ${TOOLCHAIN}/bin
}
