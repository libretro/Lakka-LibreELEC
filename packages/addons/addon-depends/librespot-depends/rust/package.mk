################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="rust"
PKG_VERSION="1.23.0"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://www.rust-lang.org"
PKG_URL=""
PKG_DEPENDS="toolchain"
PKG_SECTION="devel"
PKG_LONGDESC="Rust is a systems programming language that runs blazingly fast, prevents segfaults, and guarantees thread safety."
PKG_TOOLCHAIN="manual"

unpack() {
  :
}

make_target() {
  export CARGO_HOME="$TOOLCHAIN/.cargo"
  export RUSTUP_HOME="$CARGO_HOME"
  export PATH="$CARGO_HOME/bin:$PATH"
  rm -rf "$CARGO_HOME"
  curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
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
