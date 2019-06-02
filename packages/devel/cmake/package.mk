# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cmake"
PKG_VERSION="3.14.5"
PKG_SHA256="505ae49ebe3c63c595fa5f814975d8b72848447ee13b6613b0f8b96ebda18c06"
PKG_LICENSE="BSD"
PKG_SITE="http://www.cmake.org/"
PKG_URL="http://www.cmake.org/files/v${PKG_VERSION%.*}/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="ccache:host openssl:host"
PKG_LONGDESC="A cross-platform, open-source make system."
PKG_TOOLCHAIN="configure"

configure_host() {
  ../configure --prefix=$TOOLCHAIN \
               --no-qt-gui --no-system-libs \
               -- \
               -DCMAKE_C_FLAGS="-O2 -Wall -pipe -Wno-format-security" \
               -DCMAKE_CXX_FLAGS="-O2 -Wall -pipe -Wno-format-security" \
               -DCMAKE_EXE_LINKER_FLAGS="$HOST_LDFLAGS" \
               -DCMAKE_USE_OPENSSL=ON \
               -DBUILD_CursesDialog=0
}
