# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-or1k-linux"
PKG_VERSION="2021.11-5"
PKG_SHA256="409e4a7473125e7de7c8b0e6bc1cb971d53e63ac057e9a19102e4ce1467f442a"
PKG_LICENSE="GPL"
PKG_SITE="https://toolchains.bootlin.com/releases_openrisc.html"
PKG_URL="https://toolchains.bootlin.com/downloads/releases/toolchains/openrisc/tarballs/openrisc--musl--stable-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="OpenRISC 1000 GNU Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/lib/gcc-or1k-linux/
    cp -a * ${TOOLCHAIN}/lib/gcc-or1k-linux

  # wrap gcc and g++ with ccache like in gcc package.mk
  PKG_GCC_PREFIX="${TOOLCHAIN}/lib/gcc-or1k-linux/bin/or1k-linux-"

  rm -f "${PKG_GCC_PREFIX}gcc"
cat > "${PKG_GCC_PREFIX}gcc" << EOF
#!/bin/sh
${TOOLCHAIN}/bin/ccache ${TOOLCHAIN}/lib/gcc-or1k-linux/bin/or1k-buildroot-linux-musl-gcc "\$@"
EOF

  chmod +x "${PKG_GCC_PREFIX}gcc"

  rm -f "${PKG_GCC_PREFIX}g++"
cat > "${PKG_GCC_PREFIX}g++" << EOF
#!/bin/sh
${TOOLCHAIN}/bin/ccache ${TOOLCHAIN}/lib/gcc-or1k-linux/bin/or1k-buildroot-linux-musl-g++ "\$@"
EOF

  chmod +x "${PKG_GCC_PREFIX}g++"
}
