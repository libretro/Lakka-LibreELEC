# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="stress-ng"
PKG_VERSION="0.12.09"
PKG_SHA256="cffac091082c7adbfec649be3c66941c3d622f8b96795656bcce2e20d669cfeb"
PKG_LICENSE="GPLv2"
PKG_SITE="https://kernel.ubuntu.com/~cking/stress-ng/"
PKG_URL="https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain attr keyutils libaio libcap zlib"
PKG_LONGDESC="stress-ng will stress test a computer system in various selectable ways"
PKG_BUILD_FLAGS="-sysroot"
