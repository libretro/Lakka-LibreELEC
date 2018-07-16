# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gcc-linaro-arm-eabi"
PKG_VERSION="4.9-2016.02"
PKG_SHA256="b46f97e1eea542e98ed7e4278a4ea98c750e679b816d5a8c66286cd4fdc42448"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE=""
PKG_URL="https://releases.linaro.org/components/toolchain/binaries/${PKG_VERSION}/arm-eabi/gcc-linaro-${PKG_VERSION}-x86_64_arm-eabi.tar.xz"
PKG_SOURCE_DIR="gcc-linaro-${PKG_VERSION}-x86_64_arm-eabi"
PKG_DEPENDS_HOST="toolchain"
PKG_SECTION="lang"
PKG_LONGDESC="Linaro Aarch64 GNU Linux Binary Toolchain"
PKG_TOOLCHAIN="manual"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/lib/gcc-linaro-arm-eabi/
    cp -a * $TOOLCHAIN/lib/gcc-linaro-arm-eabi
}
