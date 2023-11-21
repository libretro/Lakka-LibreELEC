# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="brcmfmac_sdio-firmware-rpi"
PKG_VERSION="26ff205b45dc109b498a70aaf182804ad9dbfea5"
PKG_SHA256="2f0917b104739455dd488dd8f5af2ee4430801a7ac8fe8d9866e74bfbb185356"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/LibreELEC/LibreELEC.tv"
PKG_URL="https://github.com/LibreELEC/${PKG_NAME}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Firmware for brcm bluetooth chips used on RaspberryPi devices."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  DESTDIR=${INSTALL}/$(get_kernel_overlay_dir) ./install
}
