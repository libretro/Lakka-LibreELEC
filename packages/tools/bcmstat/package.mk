# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcmstat"
PKG_VERSION="0.5.3"
PKG_SHA256="eec3ddccefe9cc31c51f163e5ed7257e97efdde91eda6c5f7e60734736390cf3"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/MilhouseVH/bcmstat"
PKG_URL="https://github.com/MilhouseVH/$PKG_NAME/archive/$PKG_VERSION.tar.gz"
PKG_LONGDESC="Raspberry Pi monitoring script"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
    cp -PRv bcmstat.sh $INSTALL/usr/bin
    chmod +x $INSTALL/usr/bin/*
}
