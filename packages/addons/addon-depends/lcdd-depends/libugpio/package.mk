# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libugpio"
PKG_VERSION="0.0.6"
PKG_SHA256="5093c34cdb891560b0807cb371521cf94fa5c090ee7a84779663b16c831b9e9e"
PKG_LICENSE="LGPLv2.1"
PKG_SITE="https://github.com/mhei/libugpio"
PKG_URL="https://github.com/mhei/$PKG_NAME/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_LONGDESC="A software library to ease the use of linux kernel's sysfs gpio interface from C programs and/or other libraries."
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared"
