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

PKG_NAME="x86-firmware"
PKG_VERSION="c4c07a8"
PKG_ARCH="x86_64"
PKG_LICENSE="other"
PKG_SITE="http://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/"
PKG_URL="http://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/snapshot/$PKG_VERSION.tar.xz"
PKG_SOURCE_DIR="$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="x86-firmware: x86 related firmware"
PKG_LONGDESC="x86-firmware: x86 related firmware"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

configure_target() {
  :
}

make_target() {
  :
}

makeinstall_target() {
  :
}
