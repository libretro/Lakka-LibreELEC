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

PKG_NAME="firmware-imx"
PKG_VERSION="3.14.28-1.0.0"
PKG_REV="1"
PKG_ARCH="arm"
PKG_LICENSE="other"
PKG_SITE="http://www.freescale.com"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="linux-firmware"
PKG_SHORTDESC="firmware-imx: Freescale IMX firmware"
PKG_LONGDESC="firmware-imx: Freescale IMX firmware such as for the VPU"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  : # nothing todo here
}

makeinstall_target() {
  mkdir -p $INSTALL/lib/firmware/vpu
    cp -P firmware/vpu/vpu_fw_imx6d.bin $INSTALL/lib/firmware/vpu
    cp -P firmware/vpu/vpu_fw_imx6q.bin $INSTALL/lib/firmware/vpu
}
