# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ninja"
PKG_VERSION="1.10.2"
PKG_SHA256="ce35865411f0490368a8fc383f29071de6690cbadc27704734978221f25e2bed"
PKG_LICENSE="Apache"
PKG_SITE="https://ninja-build.org/"
PKG_URL="https://github.com/ninja-build/ninja/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="Python3:host"
PKG_LONGDESC="Small build system with a focus on speed"
PKG_TOOLCHAIN="cmake-make"

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/bin
    cp ninja ${TOOLCHAIN}/bin
}
