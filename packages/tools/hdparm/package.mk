# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hdparm"
PKG_VERSION="9.58"
PKG_SHA256="9ae78e883f3ce071d32ee0f1b9a2845a634fc4dd94a434e653fdbef551c5e10f"
PKG_LICENSE="BSD"
PKG_SITE="http://sourceforge.net/projects/hdparm/"
PKG_URL="$SOURCEFORGE_SRC/$PKG_NAME/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Shell utility to access/tune ioctl features of the Linux IDE driver and IDE drives."

makeinstall_target() {
  mkdir -p $INSTALL/usr/sbin
    cp -a $PKG_BUILD/hdparm $INSTALL/usr/sbin
}
