# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="ytop"
PKG_VERSION="0.6.2"
PKG_SHA256="d9fd6ce00e27de894bc0790947fbeab40e81e34afa5ead5a53d126c458d50e99"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/cjbassi/ytop"
PKG_URL="https://github.com/cjbassi/ytop/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain rust"
PKG_LONGDESC="A TUI system monitor written in Rust."
PKG_TOOLCHAIN="manual"

make_target() {
  . "$(get_build_dir rust)/cargo/env"
  cargo build \
    --release \
    --locked \
    --all-features
}

makeinstall_target() {
  mkdir -p $INSTALL
  cp $PKG_BUILD/.$TARGET_NAME/*/release/ytop $INSTALL
}
