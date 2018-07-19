# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="imon-mce"
PKG_VERSION="7.0"
PKG_REV="101"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="driver/remote"
PKG_SHORTDESC="iMON-MCE: a Linux driver to add support for MCE remotes to the iMON driver"
PKG_LONGDESC="Install this to add support for iMon MCE remote controls."
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="iMON-MCE"
PKG_ADDON_TYPE="xbmc.service"

addon() {
  :
}
