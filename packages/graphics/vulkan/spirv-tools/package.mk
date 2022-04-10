# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="spirv-tools"
# The SPIRV-Tools have to be specific versions matching the glslang pkg version
# https://github.com/KhronosGroup/glslang/blob/11.8.0/known_good.json
# if you update glslang make sure spirv-tools & spirv-headers versions a known good
PKG_VERSION="73735db943d7165d725883a1da0ad9eac79c1e34"
PKG_SHA256="28551980e0b69c2d188f9705747e7e3b0836a957e1ddce14ad1dfa621bed1ace"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/SPIRV-Tools"
PKG_URL="https://github.com/KhronosGroup/SPIRV-Tools/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="The SPIR-V Tools project provides an API and commands for processing SPIR-V modules."
PKG_TOOLCHAIN="manual"
