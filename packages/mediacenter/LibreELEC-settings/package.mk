# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="LibreELEC-settings"
PKG_VERSION="4294fe8aecd1ef23d449de949f43c176b9eeac7e"
PKG_SHA256="d2cc4ba9a9aa19c3c79a9bba80bad22e9378d202d327f6765331e20960680090"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL="https://github.com/LibreELEC/service.libreelec.settings/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain Python3 connman pygobject dbus-python dbussy"
PKG_LONGDESC="LibreELEC-settings: is a settings dialog for LibreELEC"

PKG_MAKE_OPTS_TARGET="DISTRONAME=$DISTRONAME ROOT_PASSWORD=$ROOT_PASSWORD"

if [ "$DISPLAYSERVER" = "x11" ]; then
  PKG_DEPENDS_TARGET+=" setxkbmap"
else
  PKG_DEPENDS_TARGET+=" bkeymaps"
fi

post_makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libreelec
    cp $PKG_DIR/scripts/* $INSTALL/usr/lib/libreelec
    sed -e "s/@DISTRONAME@/$DISTRONAME/g" \
      -i $INSTALL/usr/lib/libreelec/backup-restore

  ADDON_INSTALL_DIR=$INSTALL/usr/share/kodi/addons/service.libreelec.settings

  python_compile $ADDON_INSTALL_DIR/resources/lib/

  python_compile $ADDON_INSTALL_DIR/defaults.py

  python_compile $ADDON_INSTALL_DIR/oe.py
}

post_install() {
  enable_service backup-restore.service
  enable_service factory-reset.service
}
