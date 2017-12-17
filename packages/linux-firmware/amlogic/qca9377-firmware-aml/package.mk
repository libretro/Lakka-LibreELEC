################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

PKG_NAME="qca9377-firmware-aml"
PKG_VERSION="1.0.0"
PKG_SHA256="239b10d6fb006f566aa20638a81f98a447fa222e6b74bed2f6039a75b8ccd422"
PKG_ARCH="arm aarch64"
PKG_LICENSE="BSD-3c"
PKG_SITE="http://linode.boundarydevices.com/repos/apt/ubuntu-relx/pool/main/q/qca-firmware/"
PKG_URL="http://linode.boundarydevices.com/repos/apt/ubuntu-relx/pool/main/q/qca-firmware/qca-firmware_${PKG_VERSION}.orig.tar.gz"
PKG_SOURCE_DIR="qca-firmware-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_SHORTDESC="qca9377 Linux firmware"
PKG_LONGDESC="qca9377 Linux firmware"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_firmware_dir)
    cp -a *.bin $INSTALL/$(get_full_firmware_dir)
    cp -a qca $INSTALL/$(get_full_firmware_dir)
    cp -a wlan $INSTALL/$(get_full_firmware_dir)
    cp LICENSE.TXT $INSTALL/$(get_full_firmware_dir)/LICENSE.qca
}
