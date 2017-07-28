################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
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

PKG_NAME="aml-dtbtools"
PKG_VERSION="cce100f"
PKG_SHA256="8bcaa83fcc9e85c9c04930e7411447d96a97da0809c5ecd9af91c8b554133c41"
PKG_ARCH="any"
PKG_LICENSE="free"
PKG_SITE="https://github.com/Wilhansen/aml-dtbtools"
PKG_URL="https://github.com/Wilhansen/aml-dtbtools/archive/${PKG_VERSION}.tar.gz"
PKG_SECTION="tools"
PKG_SHORTDESC="AML DTB Tools"
PKG_LONGDESC="AML DTB Tools"

PKG_MAKE_OPTS_HOST="dtbTool"

makeinstall_host() {
  mkdir -p $TOOLCHAIN/bin
    cp dtbTool $TOOLCHAIN/bin
}
