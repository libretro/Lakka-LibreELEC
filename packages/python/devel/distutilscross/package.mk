################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="distutilscross"
PKG_VERSION="0.1"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://bitbucket.org/lambacck/distutilscross/"
PKG_URL="http://pypi.python.org/packages/source/d/distutilscross/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python:host setuptools:host"
PKG_PRIORITY="optional"
PKG_SECTION="python/devel"
PKG_SHORTDESC="distutilscross: Cross Compile Python Extensions"
PKG_LONGDESC="distutilscross enhances distutils to support Cross Compile of Python extensions"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_host() {
 : # nothing todo
}

makeinstall_host() {
  python setup.py install --prefix=$ROOT/$TOOLCHAIN
}
