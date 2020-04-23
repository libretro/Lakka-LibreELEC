# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="xcb-proto"
PKG_VERSION="1.14"
PKG_SHA256="186a3ceb26f9b4a015f5a44dcc814c93033a5fc39684f36f1ecc79834416a605"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="http://xcb.freedesktop.org/dist/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain util-macros Python3:host"
PKG_LONGDESC="X C-language Bindings protocol headers."

post_makeinstall_target() {
  python_remove_source
}
