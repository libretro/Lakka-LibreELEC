################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="tslib"
PKG_VERSION="1.1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/kergoth/tslib"
PKG_URL="https://github.com/kergoth/tslib/releases/download/1.1/$PKG_NAME-$PKG_VERSION.tar.xz"
PKG_DEPENDS_TARGET="toolchain evtest"
PKG_SECTION="service/system"
PKG_SHORTDESC="Touchscreen access library with ts_uinput_touch daemon."
PKG_LONGDESC="Touchscreen access library with ts_uinput_touch daemon."
PKG_AUTORECONF="yes"

PKG_IS_ADDON="no"

TSLIB_MODULES_ENABLED="linear dejitter variance pthres ucb1x00 tatung input galax dmc touchkit st1232 waveshare"
TSLIB_MODULES_DISABLED="arctic2 corgi collie h3600 linear_h2200 mk712 cy8mrln_palmpre"
TSLIB_BUILD_STATIC="yes"  # no .so files (easy to manage)

pre_configure_target() {
  local OPTS_MODULES=""

  if [ "$TSLIB_BUILD_STATIC" = "yes" ]; then
    OPTS_MODULES="--enable-static --disable-shared"
    for module in $TSLIB_MODULES_ENABLED; do
      OPTS_MODULES="$OPTS_MODULES --enable-$module=static"
    done
  fi

  for module in $TSLIB_MODULES_DISABLED; do
    OPTS_MODULES="$OPTS_MODULES --disable-$module"
  done

  PKG_CONFIGURE_OPTS_TARGET="$OPTS_MODULES \
    --sysconfdir=/storage/.kodi/userdata/addon_data/service.touchscreen"
}

post_makeinstall_target() {
  rm -fr $INSTALL/etc
  rm -fr $INSTALL/storage

  debug_strip $INSTALL/usr/bin
}
