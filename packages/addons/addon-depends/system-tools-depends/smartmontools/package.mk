# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="smartmontools"
PKG_VERSION="7.0"
PKG_SHA256="e5e1ac2786bc87fdbd6f92d0ee751b799fbb3e1a09c0a6a379f9eb64b3e8f61c"
PKG_LICENSE="GPL"
PKG_SITE="https://www.smartmontools.org"
PKG_URL="https://downloads.sourceforge.net/sourceforge/smartmontools/smartmontools-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Control and monitor storage systems using S.M.A.R.T."

PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr \
                           --without-initscriptdir \
                           --without-nvme-devicescan \
                           --without-systemdenvfile \
                           --without-systemdsystemunitdir \
                           --without-systemdenvfile \
                           --without-systemdsystemunitdir"

makeinstall_target() {
  :
}
