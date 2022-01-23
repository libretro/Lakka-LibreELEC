# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2021-present Frank Hartung (supervisedthinking (@) gmail.com)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="spirv-headers"
# The SPIRV-Headers have to be specific versions matching the glslang pkg version
# https://github.com/KhronosGroup/glslang/blob/master/known_good.json
PKG_VERSION="814e728b30ddd0f4509233099a3ad96fd4318c07"
PKG_SHA256="c262d3c0c36ad5c87fbe3572aa292d2aed4dcd9b1ca4868eff9ec180e3f994f2"
PKG_LICENSE="Apache-2.0"
PKG_SITE="https://github.com/KhronosGroup/SPIRV-headers"
PKG_URL="https://github.com/KhronosGroup/SPIRV-headers/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST=""
PKG_LONGDESC="SPIRV-Headers"
PKG_TOOLCHAIN="manual"
