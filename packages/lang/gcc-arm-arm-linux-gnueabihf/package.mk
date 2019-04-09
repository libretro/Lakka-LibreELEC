# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-arm-arm-linux-gnueabihf"
PKG_VERSION="8.3-2019.03"
PKG_SHA256="d4f6480ecaa99e977e3833cc8a8e1263f9eecd1ce2d022bb548a24c4f32670f5"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="https://developer.arm.com/-/media/Files/downloads/gnu-a/${PKG_VERSION}/binrel/gcc-arm-${PKG_VERSION}-x86_64-arm-linux-gnueabihf.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="ARM GNU Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/gcc-arm-arm-linux-gnueabihf/
    cp -a * $TOOLCHAIN/lib/gcc-arm-arm-linux-gnueabihf

  # wrap gcc and g++ with ccache like in gcc package.mk
  PKG_GCC_PREFIX="$TOOLCHAIN/lib/gcc-arm-arm-linux-gnueabihf/bin/arm-linux-gnueabihf-"

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
