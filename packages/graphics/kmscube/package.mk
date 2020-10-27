# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="kmscube"
PKG_VERSION="26326be53e30da9c101075fda081d38ea9ec758d"
PKG_SHA256="ce96a78edd37387058a81070950c993853f427959cfafc15cfc5f78e9f2e9b07"
PKG_LICENSE="GPL"
PKG_SITE="https://gitlab.freedesktop.org/mesa/kmscube"
PKG_URL="https://gitlab.freedesktop.org/mesa/kmscube/-/archive/master/kmscube-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Example KMS/GBM/EGL application"

if [ "$OPENGLES_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
elif [ "$OPENGL_SUPPORT" = "yes" ]; then
  echo "kmscube only supports OpenGLESv2"
  exit 0
fi
