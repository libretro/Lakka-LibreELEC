################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017 Team LibreELEC
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

PKG_NAME="gptfdisk"
PKG_VERSION="1.0.1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.rodsbooks.com/gdisk/"
PKG_URL="https://downloads.sourceforge.net/project/$PKG_NAME/$PKG_NAME/$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain popt"
PKG_SECTION="system"
PKG_SHORTDESC="GPT text-mode partitioning tools"
PKG_LONGDESC="GPT text-mode partitioning tools"
PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  make sgdisk "CC=$CC" "CXX=$CXX"
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/sbin/
    cp -p sgdisk $INSTALL/usr/sbin/
}
