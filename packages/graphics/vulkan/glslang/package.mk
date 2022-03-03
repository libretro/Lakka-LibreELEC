# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glslang"
PKG_VERSION="11.7.1"
PKG_SHA256="ab2e2ddc507bb418b9227cbe6f443eb06e89e2387944f42026d82c0b4ef79b0a"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/glslang"
PKG_URL="https://github.com/KhronosGroup/glslang/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host Python3:host spirv-tools:host spirv-headers:host"
PKG_LONGDESC="Khronos-reference front end for GLSL/ESSL, partial front end for HLSL, and a SPIR-V generator."

pre_configure_host() {
  PKG_CMAKE_OPTS_HOST="-DBUILD_SHARED_LIBS=OFF \
                       -DBUILD_EXTERNAL=ON \
                       -DENABLE_SPVREMAPPER=OFF \
                       -DENABLE_GLSLANG_JS=OFF \
                       -DENABLE_RTTI=OFF \
                       -DENABLE_EXCEPTIONS=OFF \
                       -DENABLE_OPT=ON \
                       -DENABLE_PCH=ON \
                       -DENABLE_CTEST=OFF \
                       -DENABLE_RTTI=OFF \
                       -Wno-dev"

  # The SPIRV-Tools & SPIRV-Headers have to be specific versions matching the pkg version
  # https://github.com/KhronosGroup/glslang/blob/${PKG_VERSION}/known_good.json
  mkdir -p ${PKG_BUILD}/External/spirv-tools/external/spirv-headers
    cp -R $(get_build_dir spirv-tools)/* ${PKG_BUILD}/External/spirv-tools
    cp -R $(get_build_dir spirv-headers)/* ${PKG_BUILD}/External/spirv-tools/external/spirv-headers
}
