# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tigervnc"
PKG_VERSION="1.8.0"
PKG_SHA256="9951dab0e10f8de03996ec94bec0d938da9f36d48dca8c954e8bbc95c16338f8"
PKG_REV="103"
PKG_ARCH="x86_64"
PKG_LICENSE="GPLv2"
PKG_SITE="http://www.tigervnc.org"
PKG_URL="https://github.com/TigerVNC/tigervnc/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain cmake:host libX11 libXdamage libXext libXtst zlib libjpeg-turbo"
PKG_SECTION="service"
PKG_SHORTDESC="$PKG_ADDON_NAME server"
PKG_LONGDESC="$PKG_ADDON_NAME ($PKG_VERSION) is a high-performance, platform-neutral implementation of Virtual Network Computing, a client/server application that allows users to launch and interact with graphical applications on remote machines"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="TigerVNC"
PKG_ADDON_TYPE="xbmc.service"

PKG_CMAKE_OPTS_TARGET="-DBUILD_VIEWER=off -Wno-dev"

makeinstall_target() {
  : # nothing to do
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp $PKG_BUILD/.$TARGET_NAME/unix/vncconfig/vncconfig     \
     $PKG_BUILD/.$TARGET_NAME/unix/vncpasswd/vncpasswd     \
     $PKG_BUILD/.$TARGET_NAME/unix/x0vncserver/x0vncserver \
     $ADDON_BUILD/$PKG_ADDON_ID/bin/
}
