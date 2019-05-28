# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cmake"
PKG_VERSION="3.14.4"
PKG_SHA256="00b4dc9b0066079d10f16eed32ec592963a44e7967371d2f5077fd1670ff36d9"
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
