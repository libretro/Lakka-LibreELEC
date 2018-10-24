# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="glm"
PKG_VERSION="0.9.9.2"
PKG_SHA256="209b5943d393925e1a6ecb6734e7507b8f6add25e72a605b25d0d0d382e64fd4"
PKG_LICENSE="MIT"
PKG_SITE="https://glm.g-truc.net/"
PKG_URL="https://github.com/g-truc/glm/releases/download/$PKG_VERSION/glm-$PKG_VERSION.zip"
PKG_SOURCE_DIR="glm"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="OpenGL Mathematics (GLM)"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi
