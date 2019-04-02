# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-arm-aarch64-linux-gnu"
PKG_VERSION="8.3-2019.03"
PKG_SHA256="8ce3e7688a47d8cd2d8e8323f147104ae1c8139520eca50ccf8a7fa933002731"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="https://developer.arm.com/-/media/Files/downloads/gnu-a/${PKG_VERSION}/binrel/gcc-arm-${PKG_VERSION}-x86_64-aarch64-linux-gnu.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="ARM Aarch64 GNU Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/gcc-arm-aarch64-linux-gnu/
    cp -a * $TOOLCHAIN/lib/gcc-arm-aarch64-linux-gnu

  # wrap gcc and g++ with ccache like in gcc package.mk
  PKG_GCC_PREFIX="$TOOLCHAIN/lib/gcc-arm-aarch64-linux-gnu/bin/aarch64-linux-gnu-"

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
