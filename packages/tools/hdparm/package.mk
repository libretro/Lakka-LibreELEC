# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="hdparm"
PKG_VERSION="9.56"
PKG_SHA256="6ff9ed695f1017396eec4101f990f114b7b0e0a04c5aa6369c0394053d16e4da"
PKG_LICENSE="BSD"
PKG_SITE="http://sourceforge.net/projects/hdparm/"
PKG_URL="$SOURCEFORGE_SRC/$PKG_NAME/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Shell utility to access/tune ioctl features of the Linux IDE driver and IDE drives."

makeinstall_target() {
  mkdir -p $INSTALL/usr/sbin
    cp -a $PKG_BUILD/hdparm $INSTALL/usr/sbin
}
