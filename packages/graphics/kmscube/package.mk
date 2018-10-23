# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="kmscube"
PKG_VERSION="98f31bf"
PKG_SHA256="78b52b9e606f0d3444e10ea2ed7c0c03a87f1ad2ef99e35036551395faade041"
PKG_LICENSE="GPL"
PKG_SITE="https://cgit.freedesktop.org/mesa/kmscube"
PKG_URL="https://cgit.freedesktop.org/mesa/kmscube/snapshot/$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Example KMS/GBM/EGL application"
PKG_TOOLCHAIN="autotools"

if [ "$OPENGLES_SUPPORT" = "yes" ]; then
  PKG_DEPENDS_TARGET+=" $OPENGLES"
elif [ "$OPENGL_SUPPORT" = "yes" ]; then
  echo "kmscube only supports OpenGLESv2"
  exit 0
fi
