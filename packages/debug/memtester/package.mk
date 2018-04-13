################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

PKG_NAME="memtester"
PKG_VERSION="4.3.0"
PKG_SHA256="f9dfe2fd737c38fad6535bbab327da9a21f7ce4ea6f18c7b3339adef6bf5fd88"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://pyropus.ca/software/memtester/"
PKG_URL="http://pyropus.ca/software/memtester/old-versions/memtester-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="debug"
PKG_SHORTDESC="A userspace utility for testing the memory subsystem for faults"
PKG_TOOLCHAIN="manual"

make_target() {
  make memtester
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp memtester $INSTALL/usr/bin
}
