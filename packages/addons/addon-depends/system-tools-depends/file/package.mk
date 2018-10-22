# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="file"
PKG_VERSION="2198460"
PKG_SHA256="d825eeee9e0a20b79dbcd00c51022b69fe4468354d8ccc03f441eb349ad8bde0"
PKG_LICENSE="BSD"
PKG_SITE="http://www.darwinsys.com/file/"
PKG_URL="https://github.com/file/file/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="ccache:host"
PKG_DEPENDS_TARGET="toolchain zlib file:host"
PKG_LONGDESC="The file utility is used to determine the types of various files."
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_HOST="--enable-fsect-man5 --enable-static --disable-shared"
PKG_CONFIGURE_OPTS_TARGET="--enable-fsect-man5 --enable-static --disable-shared"

makeinstall_target() {
  :
}
