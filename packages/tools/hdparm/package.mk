# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

PKG_NAME="hdparm"
PKG_VERSION="9.52"
PKG_SHA256="c3429cd423e271fa565bf584598fd751dd2e773bb7199a592b06b5a61cec4fb6"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="http://sourceforge.net/projects/hdparm/"
PKG_URL="$SOURCEFORGE_SRC/$PKG_NAME/$PKG_NAME/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="tools"
PKG_SHORTDESC="hdparm: Get/set hard disk parameters"
PKG_LONGDESC="Shell utility to access/tune ioctl features of the Linux IDE driver and IDE drives."

makeinstall_target() {
  mkdir -p $INSTALL/usr/sbin
    cp -a $PKG_BUILD/hdparm $INSTALL/usr/sbin
}
