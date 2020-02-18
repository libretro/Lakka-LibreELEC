# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glm"
PKG_VERSION="0.9.9.7"
PKG_SHA256="6b79c3d06d9745d1cce3f38c0c15666596f9aefff25ddb74df3af0a02f011ee1"
PKG_LICENSE="MIT"
PKG_SITE="https://glm.g-truc.net/"
PKG_URL="https://github.com/g-truc/glm/releases/download/$PKG_VERSION/glm-$PKG_VERSION.zip"
PKG_SOURCE_DIR="glm"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="OpenGL Mathematics (GLM)"

# Hack install solution until cmake install restored in upstream package
makeinstall_target() {
  target_has_feature 32bit && PKG_VOID_SIZE=4 || PKG_VOID_SIZE=8

  for _dir in ${SYSROOT_PREFIX} ${INSTALL}; do
    mkdir -p ${_dir}/usr/include ${_dir}/usr/lib/pkgconfig ${_dir}/usr/lib/cmake/glm
      cp -r ${PKG_BUILD}/glm ${_dir}/usr/include
      cp ${PKG_DIR}/config/glm.pc ${_dir}/usr/lib/pkgconfig
      cp ${PKG_DIR}/config/*.cmake ${_dir}/usr/lib/cmake/glm

      sed -e "s/@@VERSION@@/${PKG_VERSION}/g" \
          -e "s/@@VOID_SIZE@@/${PKG_VOID_SIZE}/g" \
          -i ${_dir}/usr/lib/pkgconfig/glm.pc ${_dir}/usr/lib/cmake/glm/*.cmake
  done
}
