# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="stress-ng"
PKG_VERSION="0.11.14"
PKG_SHA256="b21436fdbd9dc482a3fd95ae27cccf0097d0f226361ea3785215f7a4ad50136b"
PKG_LICENSE="GPLv2"
PKG_SITE="http://kernel.ubuntu.com/~cking/stress-ng/"
PKG_URL="http://kernel.ubuntu.com/~cking/tarballs/stress-ng/stress-ng-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain attr keyutils libaio libcap zlib"
PKG_LONGDESC="stress-ng will stress test a computer system in various selectable ways"
PKG_BUILD_FLAGS="-sysroot"
