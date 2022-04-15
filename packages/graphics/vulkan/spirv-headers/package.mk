# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="spirv-headers"
# The SPIRV-Headers have to be specific versions matching the glslang pkg version
# https://github.com/KhronosGroup/glslang/blob/11.9.0/known_good.json
# if you update glslang make sure spirv-tools & spirv-headers versions a known good
PKG_VERSION="4995a2f2723c401eb0ea3e10c81298906bf1422b"
PKG_SHA256="2c9fe1bbd74a74fdabe40a7ffb322527dfc008c79e1d19d3cf41a5f006d9ab60"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/SPIRV-headers"
PKG_URL="https://github.com/KhronosGroup/SPIRV-headers/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="SPIRV-Headers"
PKG_TOOLCHAIN="manual"
