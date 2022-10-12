# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rustc-snapshot"
PKG_VERSION="$(get_pkg_version rust)"
PKG_SHA256="1f5756a03119853b53358018c5b1592940a2354c3c9f84ee7faf684e3478f8f0"
PKG_LICENSE="MIT"
PKG_SITE="https://www.rust-lang.org"
PKG_URL="https://static.rust-lang.org/dist/rustc-${PKG_VERSION}-${MACHINE_HARDWARE_NAME}-unknown-linux-gnu.tar.xz"
PKG_LONGDESC="rustc bootstrap compiler"
PKG_TOOLCHAIN="manual"
