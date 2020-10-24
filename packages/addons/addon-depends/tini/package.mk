# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tini"
PKG_VERSION="fec3683b971d9c3ef73f284f176672c44b448662"
PKG_SHA256="20ee672afa8be72f5a8334044d8c2ce31bc6f2347fa240cac9c84b6c7dbc684c"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/krallin/tini"
PKG_URL="https://github.com/krallin/tini/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Tini is a simplest init system."

PKG_MAKE_OPTS_TARGET="tini-static"

pre_configure_target(){
  sed -i "s|@tini_VERSION_GIT@| - git.${PKG_VERSION}|" $PKG_BUILD/src/tiniConfig.h.in
}

makeinstall_target() {
  :
}
