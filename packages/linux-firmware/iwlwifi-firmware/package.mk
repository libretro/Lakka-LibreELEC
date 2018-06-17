################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="iwlwifi-firmware"
PKG_VERSION="e8e1c45"
PKG_SHA256="54409b92dc7a7edf4a0be6919c09f07c018d87d9fe0ea1335dc18bc152061b8e"
PKG_ARCH="any"
PKG_LICENSE="Free-to-use"
PKG_SITE="https://github.com/LibreELEC/iwlwifi-firmware"
PKG_URL="https://github.com/LibreELEC/iwlwifi-firmware/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_SHORTDESC="iwlwifi-firmware: firmwares for various Intel WLAN drivers"
PKG_LONGDESC="iwlwifi-firmware: firmwares for various Intel WLAN drivers"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  DESTDIR=$INSTALL/$(get_kernel_overlay_dir) ./install
}
