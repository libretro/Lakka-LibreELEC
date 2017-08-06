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

PKG_NAME="slice-firmware"
PKG_VERSION="0f463cc"
PKG_ARCH="arm"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/FiveNinjas/slice-firmware"
PKG_URL="https://github.com/libreelec/slice-firmware/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain dtc"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="BCM270x firmware related stuff for Slice"
PKG_LONGDESC="BCM270x firmware related stuff for Slice"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  if [ "$PROJECT" = "Slice3" ]; then
    $(kernel_path)/scripts/dtc/dtc -O dtb -I dts -o dt-blob.bin slice3-dt-blob.dts
  elif [ "$PROJECT" = "Slice" ]; then
    $(kernel_path)/scripts/dtc/dtc -O dtb -I dts -o dt-blob.bin slice-dt-blob.dts
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/share/bootloader/
    cp -a $PKG_BUILD/dt-blob.bin $INSTALL/usr/share/bootloader/
}
