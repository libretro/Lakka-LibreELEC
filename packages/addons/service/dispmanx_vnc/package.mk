# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dispmanx_vnc"
PKG_VERSION="77b33a6"
PKG_SHA256="69ca5b7bd18709cb8df1054d1656c0be30fbdae6ccfefaffe70e313df4e31b4f"
PKG_REV="104"
PKG_ARCH="arm"
PKG_ADDON_PROJECTS="RPi"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/patrikolausson/dispmanx_vnc"
PKG_URL="https://github.com/patrikolausson/dispmanx_vnc/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libvncserver bcm2835-bootloader bcm2835-driver libconfig openssl"
PKG_SECTION="service/system"
PKG_SHORTDESC="Raspberry Pi VNC: a Virtual Network Computing server for Raspberry Pi"
PKG_LONGDESC="Raspberry Pi VNC ($PKG_VERSION) is a Virtual Network Computing (VNC) server for Raspberry Pi using dispmanx"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Raspberry Pi VNC"
PKG_ADDON_TYPE="xbmc.service"
PKG_MAINTAINER="Anton Voyl (awiouy)"

pre_make_target() {
  export SYSROOT_PREFIX
}

makeinstall_target() {
  : # nop
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
    cp -p $PKG_BUILD/dispmanx_vncserver $ADDON_BUILD/$PKG_ADDON_ID/bin
}
