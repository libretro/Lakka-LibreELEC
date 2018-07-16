# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-linaro-aarch64-elf"
PKG_VERSION="4.9-2016.02"
PKG_SHA256="67b8d6d3c764a5b2e21bf4a9cc990f6d6db691df5fcc814e34051c521346ec10"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="https://releases.linaro.org/components/toolchain/binaries/${PKG_VERSION}/aarch64-elf/gcc-linaro-${PKG_VERSION}-x86_64_aarch64-elf.tar.xz"
PKG_SOURCE_DIR="gcc-linaro-${PKG_VERSION}-x86_64_aarch64-elf"
PKG_DEPENDS_HOST="toolchain"
PKG_SECTION="lang"
PKG_LONGDESC="Linaro Aarch64 GNU Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/gcc-linaro-aarch64-elf/
    cp -a * $TOOLCHAIN/lib/gcc-linaro-aarch64-elf
}
