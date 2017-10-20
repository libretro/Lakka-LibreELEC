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

PKG_NAME="brcmfmac_sdio-firmware-imx"
PKG_VERSION="0.1"
PKG_SHA256="4c8ed8ae39ecd05d7e3aeebc98cf230912cdcc887fa78d5112f981b6f9358b6e"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/LibreELEC.tv"
PKG_URL="$DISTRO_SRC/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="firmware"
PKG_SHORTDESC="brcmfmac_sdio-firmware: firmware for brcm bluetooth chips used in some Freescale iMX based devices"
PKG_LONGDESC="Firmware for Broadcom Bluetooth chips used in some Freescale iMX based devices, and brcm-patchram-plus that downloads a patchram files in the HCD format to the Bluetooth based silicon and combo chips and other utility functions."
PKG_AUTORECONF="no"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -av brcm_patchram_plus $INSTALL/usr/bin/

  mkdir -p $INSTALL/$(get_kernel_overlay_dir)
    cp -av firmware/brcm $INSTALL/$(get_kernel_overlay_dir)
}
