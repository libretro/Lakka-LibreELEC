# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rustc-snapshot"
PKG_VERSION="$(get_pkg_version rust)"
PKG_SHA256="fc0b41c15e348ad0eeb7a6c015a922a2ac95e9577e531635558b26d99399f315"
PKG_LICENSE="MIT"
PKG_SITE="https://www.rust-lang.org"
PKG_URL="https://static.rust-lang.org/dist/rustc-${PKG_VERSION}-${MACHINE_HARDWARE_CPU}-unknown-linux-gnu.tar.xz"
PKG_LONGDESC="rustc bootstrap compiler"
PKG_TOOLCHAIN="manual"
