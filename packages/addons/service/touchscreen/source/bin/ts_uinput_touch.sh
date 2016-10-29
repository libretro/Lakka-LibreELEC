#!/bin/sh
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

. /etc/profile

oe_setup_addon service.touchscreen

if [ -d /usr/share/kodi/addons/service.touchscreen ]; then
  # addon included in image
  ADDON_DIR="/usr/share/kodi/addons/service.touchscreen"
fi

. $ADDON_DIR/bin/ts_env.sh

params=$*

if [ "$1" = "service" ]; then
  # skip service parameter and daemonize
  params="-d"
else
  # started from command line
  systemctl stop ts_uinput_touch >/dev/null 2>&1
  killall ts_uinput_touch >/dev/null 2>&1
fi

echo "    touchscreen device: '$TSLIB_TSDEVICE'"

if [ -n "$TSLIB_RES_X" -a -n "$TSLIB_RES_Y" ]; then
  echo "touchscreen resolution: '${TSLIB_RES_X}x${TSLIB_RES_Y}'"
  params="-x $TSLIB_RES_X -y $TSLIB_RES_Y $params"
fi

echo "params: .$params."
if [ ! -x $ADDON_HOME/ts_uinput_touch ]; then
  ts_uinput_touch $params
else
  echo "Using $ADDON_HOME/ts_uinput_touch"
  $ADDON_HOME/ts_uinput_touch $params
fi
