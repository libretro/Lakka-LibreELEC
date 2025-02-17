# SPDX-License-Identifier: GPL-2.0-only
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="volk"
PKG_VERSION="1.3.270"
PKG_SHA256="95530bc7850b0358e4bad899eb653f882ee8a08088257d90c5042cec02208f52"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/zeux/volk"
PKG_URL="https://github.com/zeux/volk/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vulkan-headers"
PKG_LONGDESC="Meta loader for Vulkan API"

PKG_CMAKE_OPTS_TARGET="-DVOLK_INSTALL=on"
