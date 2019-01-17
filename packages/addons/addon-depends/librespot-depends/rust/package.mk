# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="rust"
PKG_VERSION="1.31.1"
PKG_LICENSE="MIT"
PKG_SITE="https://www.rust-lang.org"
PKG_DEPENDS_TARGET="toolchain rustup.rs"
PKG_LONGDESC="A systems programming language that prevents segfaults, and guarantees thread safety."
PKG_TOOLCHAIN="manual"

make_target() {
  export CARGO_HOME="$TOOLCHAIN/.cargo"
  export RUSTUP_HOME="$CARGO_HOME"
  export PATH="$CARGO_HOME/bin:$PATH"
  rm -rf "$CARGO_HOME"
  $(get_build_dir rustup.rs)/rustup-init.sh --no-modify-path -y
  rustup default "$PKG_VERSION"
  case "$TARGET_ARCH" in
    aarch64)
      RUST_TRIPLE="aarch64-unknown-linux-gnu"
      ;;
    arm)
      RUST_TRIPLE="arm-unknown-linux-gnueabihf"
      ;;
    x86_64)
      RUST_TRIPLE="x86_64-unknown-linux-gnu"
      ;;
  esac
  if [ "$TARGET_ARCH" != "x86_64" ]; then
    rustup target add "$RUST_TRIPLE"
  fi

  cat <<EOF >"$CARGO_HOME/config"
[target.$RUST_TRIPLE]
linker = "$CC"
EOF

  cat <<'EOF' >"$CARGO_HOME/env"
export CARGO_HOME="$TOOLCHAIN/.cargo"
export CARGO_TARGET_DIR="$PKG_BUILD/.$TARGET_NAME"
export PATH="$CARGO_HOME/bin:$PATH"
export RUSTUP_HOME="$CARGO_HOME"
mkdir -p "$CARGO_TARGET_DIR"
EOF

  echo "CARGO_BUILD=\"cargo build --release --target $RUST_TRIPLE\"" \
       >>"$CARGO_HOME/env"
}
