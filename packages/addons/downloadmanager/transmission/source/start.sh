#!/bin/sh

################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2011 Stephan Raue (stephan@openelec.tv)
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
#  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

export TRANSMISSION_WEB_HOME="./web"
export PATH="$PATH:./bin"

OPENELEC_SETTINGS="$HOME/.xbmc/userdata/addon_data/addon.downloadmanager.transmission/settings.xml"

if [ ! -f "$OPENELEC_SETTINGS" ]; then
  cp settings.xml $OPENELEC_SETTINGS
fi

TRANSMISSION_START=`grep TRANSMISSION_START $OPENELEC_SETTINGS | awk '{print $3 }' | sed -e "s,value=,," -e "s,\",,g"`
TRANSMISSION_AUTH=`grep TRANSMISSION_AUTH $OPENELEC_SETTINGS | awk '{print $3 }' | sed -e "s,value=,," -e "s,\",,g"`
TRANSMISSION_USER=`grep TRANSMISSION_USER $OPENELEC_SETTINGS | awk '{print $3 }' | sed -e "s,value=,," -e "s,\",,g"`
TRANSMISSION_PWD=`grep TRANSMISSION_PWD $OPENELEC_SETTINGS | awk '{print $3 }' | sed -e "s,value=,," -e "s,\",,g"`
TRANSMISSION_IP=`grep TRANSMISSION_IP $OPENELEC_SETTINGS | awk '{print $3 }' | sed -e "s,value=,," -e "s,\",,g"`

mkdir -p /storage/downloads
mkdir -p /storage/downloads/incoming
mkdir -p /storage/downloads/watch

if [ -z "$TRANSMISSION_IP" ]; then
  TRANSMISSION_IP="*.*.*.*"
fi

TRANSMISSION_ARG="$TRANSMISSION_ARG -w /storage/downloads"
TRANSMISSION_ARG="$TRANSMISSION_ARG --incomplete-dir /storage/downloads/incoming"
TRANSMISSION_ARG="$TRANSMISSION_ARG --watch-dir /storage/downloads/watch"
TRANSMISSION_ARG="$TRANSMISSION_ARG -e /var/log/transmission.log"
TRANSMISSION_ARG="$TRANSMISSION_ARG -g /storage/.cache/transmission"
TRANSMISSION_ARG="$TRANSMISSION_ARG -a $TRANSMISSION_IP"

if [ "$TRANSMISSION_AUTH" = "true" ]; then
  TRANSMISSION_ARG="$TRANSMISSION_ARG -t"
  TRANSMISSION_ARG="$TRANSMISSION_ARG -u $TRANSMISSION_USER"
  TRANSMISSION_ARG="$TRANSMISSION_ARG -v $TRANSMISSION_PWD"
else
  TRANSMISSION_ARG="$TRANSMISSION_ARG -T"
fi

chmod +x ./bin/transmission-daemon
transmission-daemon $TRANSMISSION_ARG
