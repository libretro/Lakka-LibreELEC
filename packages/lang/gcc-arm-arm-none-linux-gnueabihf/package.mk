# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-arm-arm-none-linux-gnueabihf"
PKG_VERSION="9.2-2019.12"
PKG_SHA256="51bbaf22a4d3e7a393264c4ef1e45566701c516274dde19c4892c911caa85617"
PKG_LICENSE="GPL"
PKG_SITE="https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-a"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/gnu-a/${PKG_VERSION}/binrel/gcc-arm-${PKG_VERSION}-x86_64-arm-none-linux-gnueabihf.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="ARM AArch32 GNU Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/gcc-arm-arm-none-linux-gnueabihf/
    cp -a * $TOOLCHAIN/lib/gcc-arm-arm-none-linux-gnueabihf

  # wrap gcc and g++ with ccache like in gcc package.mk
  PKG_GCC_PREFIX="$TOOLCHAIN/lib/gcc-arm-arm-none-linux-gnueabihf/bin/arm-none-linux-gnueabihf-"

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
