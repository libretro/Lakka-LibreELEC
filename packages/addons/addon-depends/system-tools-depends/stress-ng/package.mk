# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="stress-ng"
PKG_VERSION="0.12.11"
PKG_SHA256="971393075321c24c3d5769acfabb705911d1f411ced5937b7cfea58528c1b4e6"
PKG_LICENSE="GPLv2"
PKG_SITE="https://kernel.ubuntu.com/~cking/stress-ng/"
PKG_URL="https://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain attr keyutils libaio libcap zlib"
PKG_LONGDESC="stress-ng will stress test a computer system in various selectable ways"
PKG_BUILD_FLAGS="-sysroot"
