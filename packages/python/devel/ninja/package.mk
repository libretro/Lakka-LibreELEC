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

PKG_NAME="ninja"
PKG_VERSION="1.8.2"
PKG_SHA256="86b8700c3d0880c2b44c2ff67ce42774aaf8c28cbf57725cb881569288c1c6f4"
PKG_ARCH="any"
PKG_LICENSE="Apache"
PKG_SITE="http://martine.github.io/ninja/"
PKG_URL="https://github.com/ninja-build/ninja/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_HOST="Python2:host"
PKG_SECTION="devel"
PKG_SHORTDESC="Small build system with a focus on speed"
PKG_LONGDESC="Small build system with a focus on speed"
PKG_AUTORECONF="no"

configure_host() {
  :
}

make_host() {
  python2 configure.py --bootstrap
}

makeinstall_host() {
  cp ninja $TOOLCHAIN/bin/
}
