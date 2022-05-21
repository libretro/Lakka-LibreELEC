# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cargo-snapshot"
PKG_VERSION="$(get_pkg_version rust)"
PKG_SHA256="9461727d754f865ef2a87479d40bbe4c5176f80963b7c50b7797bc8940d7a0a0"
PKG_LICENSE="MIT"
PKG_SITE="https://www.rust-lang.org"
PKG_URL="https://static.rust-lang.org/dist/cargo-${PKG_VERSION}-${MACHINE_HARDWARE_CPU}-unknown-linux-gnu.tar.xz"
PKG_LONGDESC="cargo bootstrap package"
PKG_TOOLCHAIN="manual"
