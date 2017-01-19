################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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

PKG_NAME="enum34"
PKG_VERSION="1.1.6"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://bitbucket.org/stoneleaf/enum34"
PKG_URL="https://bitbucket.org/stoneleaf/$PKG_NAME/get/$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="stoneleaf-enum34-*"
PKG_DEPENDS_TARGET="toolchain Python distutilscross:host"
PKG_PRIORITY="optional"
PKG_SECTION="python"
PKG_SHORTDESC="Python 3.4 Enum backported to 3.3, 3.2, 3.1, 2.7, 2.6, 2.5, and 2.4"
PKG_LONGDESC="Python 3.4 Enum backported to 3.3, 3.2, 3.1, 2.7, 2.6, 2.5, and 2.4"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  python setup.py build
}

makeinstall_target() {
  :
}
