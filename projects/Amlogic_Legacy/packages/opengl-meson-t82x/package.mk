# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="opengl-meson-t82x"
PKG_VERSION="915cb48"
PKG_SHA256="9b5f65afa21250b67578c250da030a5829e69131ce91b2f167b01b1ed30be781"
PKG_LICENSE="nonfree"
PKG_SITE="https://github.com/kszaq/opengl-meson-t82x"
PKG_URL="https://github.com/kszaq/opengl-meson-t82x/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libhybris"
PKG_SOURCE_DIR="$PKG_NAME-$PKG_VERSION*"
PKG_LONGDESC="OpenGL ES pre-compiled libraries for Mali GPUs. The libraries were extracted from Khadas VIM2 Android firmware."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/system
    cp -a system/* $INSTALL/system
}

post_install() {
  enable_service unbind-console.service
}
