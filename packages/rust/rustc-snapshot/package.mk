# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rustc-snapshot"
PKG_VERSION="$(get_pkg_version rust)"
PKG_SHA256="207ba4e6a0426a6bed226d8b51f2d1356515f824d00b1f52973da88ea6501b6d"
PKG_LICENSE="MIT"
PKG_SITE="https://www.rust-lang.org"
PKG_URL="https://static.rust-lang.org/dist/rustc-${PKG_VERSION}-${MACHINE_HARDWARE_NAME}-unknown-linux-gnu.tar.xz"
PKG_LONGDESC="rustc bootstrap compiler"
PKG_TOOLCHAIN="manual"
