# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-arm-aarch64-none-linux-gnu"
PKG_VERSION="9.2-2019.12"
PKG_SHA256="8dfe681531f0bd04fb9c53cf3c0a3368c616aa85d48938eebe2b516376e06a66"
PKG_LICENSE="GPL"
PKG_SITE="https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-a"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/gnu-a/${PKG_VERSION}/binrel/gcc-arm-${PKG_VERSION}-x86_64-aarch64-none-linux-gnu.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="ARM Aarch64 GNU Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/gcc-arm-aarch64-none-linux-gnu/
    cp -a * $TOOLCHAIN/lib/gcc-arm-aarch64-none-linux-gnu

  # wrap gcc and g++ with ccache like in gcc package.mk
  PKG_GCC_PREFIX="$TOOLCHAIN/lib/gcc-arm-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-"

  cp "${PKG_GCC_PREFIX}gcc" "${PKG_GCC_PREFIX}gcc.real"
cat > "${PKG_GCC_PREFIX}gcc" << EOF
#!/bin/sh
$TOOLCHAIN/bin/ccache ${PKG_GCC_PREFIX}gcc.real "\$@"
EOF

  chmod +x "${PKG_GCC_PREFIX}gcc"

  cp "${PKG_GCC_PREFIX}g++" "${PKG_GCC_PREFIX}g++.real"
cat > "${PKG_GCC_PREFIX}g++" << EOF
#!/bin/sh
$TOOLCHAIN/bin/ccache ${PKG_GCC_PREFIX}g++.real "\$@"
EOF

  chmod +x "${PKG_GCC_PREFIX}g++"
}
