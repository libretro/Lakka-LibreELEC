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

PKG_NAME="pathlib"
PKG_VERSION="1.0.1"
PKG_SHA256="6940718dfc3eff4258203ad5021090933e5c04707d5ca8cc9e73c94a7894ea9f"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://pathlib.readthedocs.org"
PKG_URL="https://pypi.python.org/packages/source/p/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python3:host"
PKG_SECTION="python/devel"
PKG_SHORTDESC="This module offers a set of classes featuring all the common operations on paths in an easy, object-oriented way"
PKG_LONGDESC="This module offers a set of classes featuring all the common operations on paths in an easy, object-oriented way"

make_host() {
  :
}

makeinstall_host() {
  python3 setup.py install --prefix=$TOOLCHAIN
}
