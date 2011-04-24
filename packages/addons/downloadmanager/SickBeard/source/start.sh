#!/bin/sh

################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2011 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2011 Anthony Nash (nash.ant@gmail.com)
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

export PATH="$PATH:./bin"
export PYTHONPATH="$PYTHONPATH:./pylib"

SICKBEARD_HOME="$HOME/.xbmc/userdata/addon_data/addon.downloadmanager.SickBeard"
SABNZBD_SETTINGS="$HOME/.xbmc/userdata/addon_data/addon.downloadmanager.SABnzbd/sabnzbd.ini"
XBMC_SETTINGS="$HOME/.xbmc/userdata/guisettings.xml"

write_ini() {
python bin/ini_tool --action=write \
                    --file=$SICKBEARD_HOME/config.ini \
                    --option="$1:$2" \
                    --value="$3"
}

read_sabconfig() {
python bin/ini_tool --action=read \
                    --file=$SABNZBD_SETTINGS \
                    --option="$1:$2"
}

read_xbmcconfig() {
grep "<$1>" $XBMC_SETTINGS | sed -e "s,[[:space:]]*<$1>,," -e "s,</$1>,,"
}

mkdir -p $SICKBEARD_HOME
chmod +x ./bin/*

sleep 5

if [ ! -f "$SICKBEARD_HOME/config.ini" ]; then
  SICKBEARD_FIRSTRUN="yes"
fi

# default values
  SICKBEARD_LOGDIR="log"
  SICKBEARD_CACHEDIR="cache"
  SICKBEARD_PORT="8082"
  SICKBEARD_LAUNCHBROWSER="0"
  SICKBEARD_VERSIONCHECK="0"
  SICKBEARD_USEIPV6="0"
  SICKBEARD_WEBLOG="0"

  SICKBEARD_USEXBMC="1"
  SICKBEARD_METADATAXBMC="1|1|1|1|1|1"

# read xbmc settings
  XBMC_HOST="127.0.0.1"
  XBMC_PORT=`read_xbmcconfig webserverport`
  XBMC_USER=`read_xbmcconfig webserverusername`
  XBMC_PWD=`read_xbmcconfig webserverpassword`

# read sabnzbd settings
  SABNZBD_HOST="127.0.0.1"
  SABNZBD_PORT="8081"
  SABNZBD_APIKEY=`read_sabconfig misc api_key`
  SABNZBD_WEBUSERNAME=`read_sabconfig misc username`
  SABNZBD_WEBPASSWORD=`read_sabconfig misc password`

if [ -z "$SICKBEARD_HOST" ]; then
  SICKBEARD_HOST="0.0.0.0"
fi

write_ini General launch_browser $SICKBEARD_LAUNCHBROWSER
write_ini General version_notify $SICKBEARD_VERSIONCHECK
write_ini General log_dir $SICKBEARD_LOGDIR
write_ini General cache_dir $SICKBEARD_CACHEDIR
write_ini General web_port $SICKBEARD_PORT
write_ini General web_host $SICKBEARD_HOST
write_ini General web_ipv6 $SICKBEARD_USEIPV6
write_ini General web_log $SICKBEARD_WEBLOG
write_ini General web_username $SABNZBD_WEBUSERNAME
write_ini General web_password $SABNZBD_WEBPASSWORD

write_ini SABnzbd sab_username $SABNZBD_WEBUSERNAME
write_ini SABnzbd sab_password $SABNZBD_WEBPASSWORD
write_ini SABnzbd sab_apikey $SABNZBD_APIKEY
write_ini SABnzbd sab_host "http://$SABNZBD_HOST:$SABNZBD_PORT/"

write_ini XBMC use_xbmc $SICKBEARD_USEXBMC
write_ini XBMC xbmc_host "$XBMC_HOST:$XBMC_PORT"
write_ini XBMC xbmc_username $XBMC_USER
write_ini XBMC xbmc_password $XBMC_PWD

if [ "$SICKBEARD_FIRSTRUN" = "yes" ]; then
write_ini General metadata_xbmc $SICKBEARD_METADATAXBMC
fi

python ./SickBeard/SickBeard.py --daemon --datadir $SICKBEARD_HOME
