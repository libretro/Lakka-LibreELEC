################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2009-2016 Lukas Rusak (lrusak@libreelec.tv)
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="tini"
PKG_VERSION="949e6fa"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="https://github.com/krallin/tini"
PKG_URL="https://github.com/krallin/tini/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="Tini is the simplest init you could think of"
PKG_LONGDESC="Tini is the simplest init you could think of"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

PKG_CMAKE_TARGET_OPTS="-DMINIMAL=ON"

PKG_MAKE_TARGET_OPTS="tini-static"

pre_configure_target(){
  sed -i "s|@tini_VERSION_GIT@| - git.${PKG_VERSION}|" $PKG_BUILD/src/tiniConfig.h.in
}

makeinstall_target() {
  :
}
