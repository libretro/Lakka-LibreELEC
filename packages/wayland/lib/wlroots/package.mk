# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="wlroots"
PKG_VERSION="0.17.3"
PKG_SHA256="b916d9574367373d42334ea12ea3cead27ebc3b8de3bea375619e537d86b0757"
PKG_LICENSE="MIT"
PKG_SITE="https://gitlab.freedesktop.org/wlroots/wlroots/"
PKG_URL="https://gitlab.freedesktop.org/wlroots/wlroots/-/archive/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain hwdata libdisplay-info libinput libxkbcommon pixman libdrm wayland wayland-protocols seatd"
PKG_LONGDESC="A modular Wayland compositor library"

PKG_RENDERERS=""

# OpenGLES Support
if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
  PKG_RENDERERS+=" gles2"
fi

# Vulkan Support
if [ "${VULKAN_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${VULKAN}"
  PKG_RENDERERS+=" vulkan"
fi

PKG_RENDERERS="${PKG_RENDERERS#* }"
PKG_RENDERERS="${PKG_RENDERERS// /,}"

PKG_MESON_OPTS_TARGET="-Dxcb-errors=disabled \
                       -Dxwayland=disabled \
                       -Dbackends=drm,libinput \
                       -Dexamples=false \
                       -Drenderers=${PKG_RENDERERS}"

pre_configure_target() {
  # wlroots does not build without -Wno flags as all warnings being treated as errors
  export TARGET_CFLAGS=$(echo "${TARGET_CFLAGS} -Wno-unused-variable -Wno-unused-but-set-variable -Wno-unused-function")
}
