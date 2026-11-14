# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="shaderc"
PKG_VERSION="v2026.1"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/google/shaderc"
PKG_URL="${PKG_SITE}.git"
# shaderc has no real .gitmodules - third_party/{glslang,spirv-tools,
# spirv-headers} are pinned in known_good.json and fetched by the
# utils/git-sync-deps script in pre_configure_target() below, not by git
# submodules. Skip Lakka's automatic submodule step, it would find nothing.
PKG_GIT_SKIP_SUBMODULE="yes"
PKG_DEPENDS_HOST="toolchain:host Python3:host"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Shaderc provides libshaderc, a library for compiling GLSL/HLSL shaders to SPIR-V, used here for Vulkan rendering."
PKG_TOOLCHAIN="cmake"

PKG_CMAKE_OPTS_TARGET="-DSHADERC_SKIP_TESTS=ON \
                       -DSHADERC_SKIP_EXAMPLES=ON \
                       -DSHADERC_SKIP_COPYRIGHT_CHECK=ON \
                       -DENABLE_GLSLANG_BINARIES=OFF \
                       -DSPIRV_SKIP_EXECUTABLES=ON"

pre_configure_target() {
  ( cd "${PKG_BUILD}" && python3 ./utils/git-sync-deps )
}

post_makeinstall_target() {
  # armsx2 only needs libshaderc; host-side tools here are target (aarch64)
  # binaries and must not be picked up by other packages (e.g. citra)
  rm -rf "${INSTALL}/usr/bin" "${SYSROOT_PREFIX}/usr/bin/glslc"
}
