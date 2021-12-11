# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-or1k-linux"
PKG_VERSION="2021.05-1"
PKG_SHA256="73c14b48015fb964ff0bf24cbed5be4cad2eac7cf9ce90e65d6cff03d2a7b18d"
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
