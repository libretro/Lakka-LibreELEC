# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="strace"
PKG_VERSION="5.4"
PKG_SHA256="f7d00514d51290b6db78ad7a9de709baf93caa5981498924cbc9a744cfd2a741"
PKG_LICENSE="BSD"
PKG_SITE="https://strace.io/"
PKG_URL="https://strace.io/files/$PKG_VERSION/strace-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="strace is a diagnostic, debugging and instructional userspace utility"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="-sysroot"
