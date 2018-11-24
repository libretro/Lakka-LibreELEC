# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="screensavers.rsxs"
PKG_VERSION="be03db6e9652a465b521cb7768b692e52ed2f1e3"
PKG_SHA256="b0f35760a3f444769c2f0f948defc220b34459dde1bea06522708498eefe2e99"
PKG_REV="2"
PKG_ARCH="broken"
PKG_LICENSE="GPL"
PKG_SITE="http://www.kodi.tv"
PKG_URL="https://github.com/notspiff/screensavers.rsxs/archive/$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain kodi-platform libXt libXmu"
PKG_SECTION=""
PKG_SHORTDESC="screensavers.rsxs"
PKG_LONGDESC="screensavers.rsxs"

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.ui.screensaver"

if [ "$OPENGL" = "no" ] ; then
  exit 0
fi

addon() {
  for _ADDON in $PKG_BUILD/.install_pkg/usr/share/$MEDIACENTER/addons/* ; do
    _ADDON_ID=$(basename $_ADDON)

    install_binary_addon $_ADDON_ID

    MULTI_ADDONS="$MULTI_ADDONS $_ADDON_ID"
  done

  # export MULTI_ADDONS so create_addon knows multiple addons
  # were installed in $ADDON_BUILD/
  export MULTI_ADDONS="$MULTI_ADDONS"
}
