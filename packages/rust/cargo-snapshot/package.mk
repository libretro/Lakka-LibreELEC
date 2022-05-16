# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cargo-snapshot"
PKG_VERSION="$(get_pkg_version rust)"
PKG_SHA256="48edb2eb51d7c56ef9a3130f0b331e83f139559161f6f93b9588d28cf72610f3"
PKG_LICENSE="MIT"
PKG_SITE="https://www.rust-lang.org"
PKG_URL="https://static.rust-lang.org/dist/cargo-${PKG_VERSION}-${MACHINE_HARDWARE_CPU}-unknown-linux-gnu.tar.xz"
PKG_LONGDESC="cargo bootstrap package"
PKG_TOOLCHAIN="manual"
