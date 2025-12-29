# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="kmscube"
PKG_VERSION="9f63f359fab1b5d8e862508e4e51c9dfe339ccb0"
PKG_SHA256="6f5a56929e8958e8e0d073c898c0d50d3c6ab7f070ad0d2f185a6ee2d29b57d7"
PKG_LICENSE="GPL"
PKG_SITE="https://gitlab.freedesktop.org/mesa/kmscube"
PKG_URL="https://gitlab.freedesktop.org/mesa/kmscube/-/archive/master/kmscube-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Example KMS/GBM/EGL application"

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" ${OPENGLES}"
elif [ "${OPENGL_SUPPORT}" = "yes" ]; then
  echo "kmscube only supports OpenGLESv2"
  exit 0
fi
