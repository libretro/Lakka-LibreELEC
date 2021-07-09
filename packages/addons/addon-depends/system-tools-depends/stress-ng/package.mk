# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="stress-ng"
PKG_VERSION="0.13.05"
PKG_SHA256="f058c8fba37596ab32c3a4b2aedbdbf5f2b8a8ba1d312059e733290543ad00ac"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/ColinIanKing/stress-ng"
PKG_URL="https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain attr keyutils libaio libcap zlib"
PKG_LONGDESC="stress-ng will stress test a computer system in various selectable ways"
PKG_BUILD_FLAGS="-sysroot"
