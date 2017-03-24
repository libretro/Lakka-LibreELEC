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

PKG_NAME="patch"
PKG_VERSION="2.7.5"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://savannah.gnu.org/projects/patch/"
PKG_URL="http://ftpmirror.gnu.org/patch/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="GNU patch"
PKG_LONGDESC="Patch takes a patch file containing a difference listing produced by the diff program and applies those differences to one or more original files, producing patched versions"
PKG_AUTORECONF="no"

PKG_CONFIGURE_OPTS_TARGET="--disable-xattr"

makeinstall_target() {
  : # nop
}
