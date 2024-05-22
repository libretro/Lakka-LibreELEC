# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="strace"
PKG_VERSION="6.9"
PKG_SHA256="da189e990a82e3ca3a5a4631012f7ecfd489dab459854d82d8caf6a865c1356a"
PKG_LICENSE="BSD"
PKG_SITE="https://strace.io/"
PKG_URL="https://strace.io/files/${PKG_VERSION}/strace-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="strace is a diagnostic, debugging and instructional userspace utility"
PKG_TOOLCHAIN="autotools"

if [ "${TARGET_ARCH}" = x86_64 -o "${TARGET_ARCH}" = "aarch64" ]; then
  PKG_CONFIGURE_OPTS_TARGET="--enable-mpers=no"
fi
