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

export PATH="$PATH:./bin"
export PYTHONPATH="$PYTHONPATH:./pylib"

SABNZBD_HOME="$HOME/.xbmc/userdata/addon_data/addon.downloadmanager.SABnzbd"
SABNZBD_SETTINGS="$SABNZBD_HOME/settings.xml"

SABNZBD_DISABLEAPIKEY="0"
SABNZBD_CHECKRELEASE="0"
SABNZBD_LAUNCHBROWSER="0"

SABNZBD_HTTPPORT="8081"
SABNZBD_HTTPSPORT="9081"
SABNZBD_HTTPSCERT="server.cert"
SABNZBD_HTTPSKEY="server.key"

SABNZBD_SKIN="Plush"
SABNZBD_SKIN2="Plush"
SABNZBD_WEBCOLOR="gold"
SABNZBD_WEBCOLOR2="gold"

SABNZBD_LOGDIR="logs"
SABNZBD_ADMINDIR="admin"
SABNZBD_BACKUPDIR="backup"

SABNZBD_INCOMPLETEDIR="/storage/downloads/incomplete"
SABNZBD_COMPLETEDIR="/storage/downloads"
SABNZBD_WATCHDIR="/storage/downloads/watch"

write_ini() {
python bin/ini_tool --action=write \
                    --file=$SABNZBD_HOME/sabnzbd.ini \
                    --option="$1:$2" \
                    --value="$3"
}

mkdir -p $SABNZBD_HOME
chmod +x ./bin/*

if [ ! -f "$SABNZBD_SETTINGS" ]; then
  cp settings-default.xml $SABNZBD_SETTINGS
fi

if [ ! -f "$SABNZBD_HOME/sabnzbd.ini" ]; then
  SABNZBD_FIRSTRUN="yes"
fi

# use settings from xbmc setup dialog
SABNZBD_USER=`grep SABNZBD_USER $SABNZBD_SETTINGS | awk '{print $3 }' | sed -e "s,value=,," -e "s,\",,g"`
SABNZBD_PWD=`grep SABNZBD_PWD $SABNZBD_SETTINGS | awk '{print $3 }' | sed -e "s,value=,," -e "s,\",,g"`
SABNZBD_IP=`grep SABNZBD_IP $SABNZBD_SETTINGS | awk '{print $3 }' | sed -e "s,value=,," -e "s,\",,g"`

if [ -z "$SABNZBD_IP" ]; then
  SABNZBD_IP="0.0.0.0"
fi

write_ini misc disable_api_key $SABNZBD_DISABLEAPIKEY
write_ini misc check_new_rel $SABNZBD_CHECKRELEASE
write_ini misc auto_browser $SABNZBD_LAUNCHBROWSER
write_ini misc username $SABNZBD_USER
write_ini misc password $SABNZBD_PWD
write_ini misc port $SABNZBD_HTTPPORT
write_ini misc https_port $SABNZBD_HTTPSPORT
write_ini misc https_cert $SABNZBD_HTTPSCERT
write_ini misc https_key $SABNZBD_HTTPSKEY
write_ini misc host $SABNZBD_IP
write_ini misc web_dir $SABNZBD_SKIN
write_ini misc web_dir2 $SABNZBD_SKIN2
write_ini misc web_color $SABNZBD_WEBCOLOR
write_ini misc web_color2 $SABNZBD_WEBCOLOR2
write_ini misc log_dir $SABNZBD_LOGDIR
write_ini misc admin_dir $SABNZBD_ADMINDIR
write_ini misc nzb_backup_dir $SABNZBD_BACKUPDIR

if [ "$SABNZBD_FIRSTRUN" = "yes" ]; then
  mkdir -p "$SABNZBD_INCOMPLETEDIR"
  mkdir -p "$SABNZBD_COMPLETEDIR"
  mkdir -p "$SABNZBD_WATCHDIR"
  write_ini misc download_dir $SABNZBD_INCOMPLETEDIR
  write_ini misc complete_dir $SABNZBD_COMPLETEDIR
  write_ini misc dirscan_dir $SABNZBD_WATCHDIR

  write_ini servers:localhost name "localhost"
  write_ini servers:localhost host "localhost"
  write_ini servers:localhost port "119"
  write_ini servers:localhost enable "0"
fi

python ./SABnzbd/SABnzbd.py -d -f $SABNZBD_HOME/sabnzbd.ini -l 0
