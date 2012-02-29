#!/bin/sh

################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

. /etc/profile

ADDON_DIR="$HOME/.xbmc/addons/driver.dvb.sundtek-mediatv"
ADDON_HOME="$HOME/.xbmc/userdata/addon_data/driver.dvb.sundtek-mediatv"
SUNDTEK_READY="/var/run/sundtek.ready"

mkdir -p $ADDON_HOME

if [ ! -f "$ADDON_HOME/sundtek.conf" ]; then
  cp $ADDON_DIR/config/* $ADDON_HOME/
fi

SUNDTEK_ARG="--pluginpath=$ADDON_DIR/bin --daemon"

if [ -z "$(pidof mediasrv)" ]; then
  rm -f $SUNDTEK_READY
  rm -f /tmp/sundtek.conf
  ln -sf $ADDON_HOME/sundtek.conf /tmp/sundtek.conf
  mediasrv $SUNDTEK_ARG

  # wait for device to attach
  cnt=0
  while [ 1 ]; do
    if [ -f $SUNDTEK_READY ]; then
      rm -f $SUNDTEK_READY
      break
    else if [ "$cnt" = "120" ]; then
      logger -t Tvheadend "### No Sundtek device attached in 60 sec ###"
      return
    fi
    fi
    let cnt=cnt+1
    usleep 500000
  done

  export LD_LIBRARY_PATH=$ADDON_DIR/lib:$LD_LIBRARY_PATH
  export LD_PRELOAD=$ADDON_DIR/lib/libmediaclient.so:$LD_PRELOAD

(
  # save adapter serial number in background
  sleep 4
  serial_number_old=$(cat $ADDON_HOME/adapters.txt 2>/dev/null)
  serial_number_new=$(mediaclient -e | awk '/ID:/ {print $2}')
  if [ "$serial_number_old" != "$serial_number_new" ]; then
    echo "$serial_number_new" >$ADDON_HOME/adapters.txt
  fi
)&
fi
