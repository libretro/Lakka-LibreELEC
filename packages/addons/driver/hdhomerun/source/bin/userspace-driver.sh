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

ADDON_DIR="$HOME/.xbmc/addons/driver.dvb.hdhomerun"
ADDON_HOME="$HOME/.xbmc/userdata/addon_data/driver.dvb.hdhomerun"

mkdir -p $ADDON_HOME

if [ ! -f "$ADDON_HOME/dvbhdhomerun.sample" ]; then
  cp $ADDON_DIR/config/* $ADDON_HOME/
fi

if [ -z "$(pidof userhdhomerun)" ]; then
  rm -f /tmp/dvbhdhomerun
  if [ -f $ADDON_HOME/dvbhdhomerun.conf ]; then
    ln -s $ADDON_HOME/dvbhdhomerun.conf /tmp/dvbhdhomerun
  fi

  # if not already added
  modprobe dvb_hdhomerun
  modprobe dvb_hdhomerun_fe

  mkdir -p /var/log/
  rm -f /var/log/dvbhdhomerun.log
  
  export LD_LIBRARY_PATH=$ADDON_DIR/lib:$LD_LIBRARY_PATH

  userhdhomerun -f
  # how much time should we wait?
  usleep 1000000
  if [ -f $ADDON_HOME/extra-wait.sh ]; then
    sh $ADDON_HOME/extra-wait.sh
  fi

# save adapter names in background
(
  sleep 4
  sn_old=$(cat $ADDON_HOME/adapters.txt 2>/dev/null)
  sn_new=$(grep "Name of device: " /var/log/dvbhdhomerun.log)
  if [ "$sn_old" != "$sn_new" ]; then
    echo -n $sn_new >$ADDON_HOME/adapters.txt
  fi
)&
fi
