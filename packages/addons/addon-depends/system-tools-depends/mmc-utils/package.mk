# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2022-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="mmc-utils"
PKG_VERSION="4303889c8bd9a2357587eb6ebacecb70098a264d"
PKG_SHA256="283bab1925a46eb896a9d114650923ce6a39dbb97050daa36bd0bdb6fa703d12"
PKG_LICENSE="GPL"
PKG_SITE="https://www.kernel.org/doc/html/latest/driver-api/mmc/mmc-tools.html"
PKG_URL="https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git/snapshot/mmc-utils-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Configure MMC storage devices from userspace."
PKG_BUILD_FLAGS="-sysroot"
