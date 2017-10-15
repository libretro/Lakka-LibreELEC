################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="firmware-imx"
PKG_VERSION="5.4"
PKG_SHA256="c5bd4bff48cce9715a5d6d2c190ff3cd2262c7196f7facb9b0eda231c92cc223"
PKG_ARCH="arm"
PKG_LICENSE="other"
PKG_SITE="http://www.freescale.com"
PKG_URL="http://www.nxp.com/lgfiles/NMG/MAD/YOCTO/${PKG_NAME}-${PKG_VERSION}.bin"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="firmware-imx: Freescale IMX firmware"
PKG_LONGDESC="firmware-imx: Freescale IMX firmware such as for the VPU"
PKG_AUTORECONF="no"

unpack() {
  mkdir -p $BUILD
    cd $BUILD
    sh $ROOT/$SOURCES/$PKG_NAME/$PKG_NAME-$PKG_VERSION.bin --auto-accept
}

make_target() {
  : # nothing todo here
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_firmware_dir)/vpu
    cp -P firmware/vpu/vpu_fw_imx6d.bin $INSTALL/$(get_full_firmware_dir)/vpu
    cp -P firmware/vpu/vpu_fw_imx6q.bin $INSTALL/$(get_full_firmware_dir)/vpu
}
