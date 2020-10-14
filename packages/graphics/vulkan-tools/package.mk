# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="vulkan-tools"
PKG_VERSION="1.2.156"
PKG_SHA256="066e4967609baf554541ebd03a47c831d2fb13a1f3a5f5471cb71afc8b6b603d"
PKG_LICENSE="Apache 2.0"
PKG_SITE="https://github.com/KhronosGroup/Vulkan-Tools"
PKG_URL="https://github.com/KhronosGroup/Vulkan-Tools/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain vulkan-loader vulkan-headers"
PKG_LONGDESC="Vulkan tools and utilities."

PKG_CMAKE_OPTS_TARGET+=" -DBUILD_WSI_XLIB_SUPPORT=OFF \
  -DBUILD_WSI_WAYLAND_SUPPORT=OFF \
  -DBUILD_WSI_XCB_SUPPORT=OFF \
  -DBUILD_CUBE=OFF "
