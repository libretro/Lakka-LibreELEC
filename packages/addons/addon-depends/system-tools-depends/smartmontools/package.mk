# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="smartmontools"
PKG_VERSION="6.6"
PKG_SHA256="51f43d0fb064fccaf823bbe68cf0d317d0895ff895aa353b3339a3b316a53054"
PKG_LICENSE="GPL"
PKG_SITE="https://www.smartmontools.org"
PKG_URL="https://github.com/smartmontools/smartmontools/releases/download/RELEASE_${PKG_VERSION//./_}/smartmontools-$PKG_VERSION.tar.gz"
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
