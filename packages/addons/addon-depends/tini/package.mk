# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)

PKG_NAME="tini"
PKG_VERSION="949e6fa"
PKG_SHA256="7d1ac577b44a1bd097d6684ec5090b749cdf94962f38f3ed7b46d6ec0e25c209"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/krallin/tini"
PKG_URL="https://github.com/krallin/tini/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="Tini is the simplest init you could think of"
PKG_LONGDESC="Tini is the simplest init you could think of"

PKG_CMAKE_TARGET_OPTS="-DMINIMAL=ON"

PKG_MAKE_TARGET_OPTS="tini-static"

pre_configure_target(){
  sed -i "s|@tini_VERSION_GIT@| - git.${PKG_VERSION}|" $PKG_BUILD/src/tiniConfig.h.in
}

makeinstall_target() {
  :
}
