# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-arm-aarch64-none-elf"
PKG_VERSION="11.2-2022.02"
PKG_SHA256="3b15725545a0211a17b63e72d4f10241f7ffbe7ce94cb9612590ceacde16992c"
PKG_LICENSE="GPL"
PKG_SITE="https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-a"
PKG_URL="https://developer.arm.com/-/media/Files/downloads/gnu/${PKG_VERSION}/binrel/gcc-arm-${PKG_VERSION}-aarch64-aarch64-none-elf.tar.xz"
PKG_DEPENDS_HOST="ccache:host"
PKG_LONGDESC="ARM Aarch64 GNU Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p ${TOOLCHAIN}/lib/gcc-arm-aarch64-none-elf/
    cp -a * ${TOOLCHAIN}/lib/gcc-arm-aarch64-none-elf

  # wrap gcc and g++ with ccache like in gcc package.mk
  PKG_GCC_PREFIX="${TOOLCHAIN}/lib/gcc-arm-aarch64-none-elf/bin/aarch64-none-elf-"

  cp "${PKG_GCC_PREFIX}gcc" "${PKG_GCC_PREFIX}gcc.real"
cat > "${PKG_GCC_PREFIX}gcc" << EOF
#!/bin/sh
${TOOLCHAIN}/bin/ccache ${PKG_GCC_PREFIX}gcc.real "\$@"
EOF

  chmod +x "${PKG_GCC_PREFIX}gcc"

  cp "${PKG_GCC_PREFIX}g++" "${PKG_GCC_PREFIX}g++.real"
cat > "${PKG_GCC_PREFIX}g++" << EOF
#!/bin/sh
${TOOLCHAIN}/bin/ccache ${PKG_GCC_PREFIX}g++.real "\$@"
EOF

  chmod +x "${PKG_GCC_PREFIX}g++"
}
