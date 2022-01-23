# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="spirv-tools"
# The SPIRV-Tools have to be specific versions matching the glslang pkg version
# https://github.com/KhronosGroup/glslang/blob/master/known_good.json
PKG_VERSION="21e3f681e2004590c7865bc8c0195a4ab8e66c88"
PKG_SHA256="1253ada1d3af912d43f7a9acff86c74afbdb6bdf1acd92bd61e0010c103bc050"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/SPIRV-Tools"
PKG_URL="https://github.com/KhronosGroup/SPIRV-Tools/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="The SPIR-V Tools project provides an API and commands for processing SPIR-V modules."
PKG_TOOLCHAIN="manual"
