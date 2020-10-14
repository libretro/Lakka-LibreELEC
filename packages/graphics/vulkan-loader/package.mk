# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vulkan-loader"
PKG_VERSION="1.2.156"
PKG_SHA256="7ddfec36349cf32c29fcb8ce497e3b3a0e515070cce8f3a33acddd3bd29d60c9"
PKG_LICENSE="Apache 2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Loader"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Loader/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vulkan-headers"
PKG_LONGDESC="Vulkan is an explicit API, enabling direct control over how GPUs actually work."

PKG_CMAKE_OPTS_TARGET+=" -DBUILD_WSI_XLIB_SUPPORT=OFF \
  -DBUILD_WSI_WAYLAND_SUPPORT=OFF \
  -DBUILD_WSI_XCB_SUPPORT=OFF "

