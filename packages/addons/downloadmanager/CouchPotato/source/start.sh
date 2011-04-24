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

  COUCHPOTATO_HOME="$HOME/.xbmc/userdata/addon_data/addon.downloadmanager.CouchPotato"
  SABNZBD_SETTINGS="$HOME/.xbmc/userdata/addon_data/addon.downloadmanager.SABnzbd/sabnzbd.ini"
  XBMC_SETTINGS="$HOME/.xbmc/userdata/guisettings.xml"

  write_ini() {
  python bin/ini_tool --action=write \
                      --file=$COUCHPOTATO_HOME/config.ini \
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

  mkdir -p $COUCHPOTATO_HOME
  chmod +x ./bin/*

  sleep 5

  if [ ! -f "$COUCHPOTATO_HOME/config.ini" ]; then
    COUCHPOTATO_FIRSTRUN="yes"
  fi

  # default values
    COUCHPOTATO_LAUNCHBROWSER="False"
    COUCHPOTATO_VERSIONCHECK="False"
    COUCHPOTATO_PORT="8083"
    COUCHPOTATO_USEXBMC="True"
    COUCHPOTATO_UPDATEXBMC="True"

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

  if [ -z "$COUCHPOTATO_HOST" ]; then
    COUCHPOTATO_HOST="0.0.0.0"
  fi

    write_ini global host $COUCHPOTATO_HOST
    write_ini global port $COUCHPOTATO_PORT
    write_ini global username $SABNZBD_WEBUSERNAME
    write_ini global password $SABNZBD_WEBPASSWORD
    write_ini global launchbrowser $COUCHPOTATO_LAUNCHBROWSER
    write_ini global updater $COUCHPOTATO_VERSIONCHECK

    write_ini Sabnzbd username $SABNZBD_WEBUSERNAME
    write_ini Sabnzbd password $SABNZBD_WEBPASSWORD
    write_ini Sabnzbd apikey $SABNZBD_APIKEY
    write_ini Sabnzbd host "$SABNZBD_HOST:$SABNZBD_PORT"

    write_ini XBMC enabled $COUCHPOTATO_USEXBMC
    write_ini XBMC host "$XBMC_HOST:$XBMC_PORT"
    write_ini XBMC username $XBMC_USER
    write_ini XBMC password $XBMC_PWD

    if [ "$COUCHPOTATO_FIRSTRUN" = "yes" ]; then
      write_ini XBMC updateoneonly $COUCHPOTATO_UPDATEXBMC
    fi

  python ./CouchPotato/CouchPotato.py -d --datadir $COUCHPOTATO_HOME --config $COUCHPOTATO_HOME/config.ini
