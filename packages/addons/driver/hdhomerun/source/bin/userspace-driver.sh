#!/bin/sh

################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2013 Stephan Raue (stephan@openelec.tv)
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
ADDON_SETTINGS="$ADDON_HOME/settings.xml"

# modules are not automatically loaded
modprobe dvb_hdhomerun
modprobe dvb_hdhomerun_fe

mkdir -p $ADDON_HOME

if [ ! -f "$ADDON_HOME/dvbhdhomerun.sample" ]; then
  cp $ADDON_DIR/config/* $ADDON_HOME/
fi

if [ ! -f "$ADDON_SETTINGS" ]; then
  cp $ADDON_DIR/settings-default.xml $ADDON_SETTINGS
fi

mkdir -p /var/config
cat "$ADDON_SETTINGS" | awk -F\" '{print $2"=\""$4"\""}' | sed '/^=/d' > /var/config/hdhomerun-addon.conf
. /var/config/hdhomerun-addon.conf

if [ -z "$(pidof userhdhomerun)" ]; then
  if [ "$ENABLE_TUNER_TYPES" = "true" ]; then
    DVBHDHOMERUN_CONF_TMP=/tmp/dvbhdhomerun.conf
    touch $ADDON_HOME/dvbhdhomerun.conf
    cp $ADDON_HOME/dvbhdhomerun.conf $DVBHDHOMERUN_CONF_TMP

    # get tuner serial numbers
    SERIALS=$(cat /var/config/hdhomerun-addon.conf | sed -n 's|^ATTACHED_TUNER_\(.*\)_\(.*\)_DVBMODE=.*|\1-\2|gp' | sort | uniq)
    . /var/config/hdhomerun-addon.conf

    for SERIAL in ${SERIALS[@]}; do
      SERIAL_VAR=$(echo $SERIAL | sed 's|-|_|')
      DVBMODE=$(eval echo \$ATTACHED_TUNER_${SERIAL_VAR}_DVBMODE)
      FULLNAME=$(eval echo \$ATTACHED_TUNER_${SERIAL_VAR}_FULLNAME)
      DISABLE=$(eval echo \$ATTACHED_TUNER_${SERIAL_VAR}_DISABLE)

      [ "$DVBMODE" = "auto" ] && DVBMODE=""

      # remove setttings for this tuner
      awk -v val="[$SERIAL]" '$0 == val {flag=1; next} /^tuner_type=|^use_full_name=|^disable=|^#|^$/{if (flag==1) next} /.*/{flag=0; print}' $DVBHDHOMERUN_CONF_TMP >${DVBHDHOMERUN_CONF_TMP}-types
      mv ${DVBHDHOMERUN_CONF_TMP}-types $DVBHDHOMERUN_CONF_TMP
      echo "" >>$DVBHDHOMERUN_CONF_TMP
      # remove empty lines at the end of file
      sed -i -e ':a' -e '/^\n*$/{$d;N;};/\n$/ba' $DVBHDHOMERUN_CONF_TMP

      ADDNEW=true
      if [ -n "$DVBMODE" ]; then
        [ $ADDNEW = true ] && ADDNEW=false && echo "[$SERIAL]" >>$DVBHDHOMERUN_CONF_TMP
        echo "tuner_type=$DVBMODE" >>$DVBHDHOMERUN_CONF_TMP
      fi
      if [ "$FULLNAME" = "true" ]; then
        [ $ADDNEW = true ] && ADDNEW=false && echo "[$SERIAL]" >>$DVBHDHOMERUN_CONF_TMP
        echo "use_full_name=true" >>$DVBHDHOMERUN_CONF_TMP
      fi
      if [ "$DISABLE" = "true" ]; then
        [ $ADDNEW = true ] && ADDNEW=false && echo "[$SERIAL]" >>$DVBHDHOMERUN_CONF_TMP
        echo "disable=true" >>$DVBHDHOMERUN_CONF_TMP
      fi

      echo "" >>$DVBHDHOMERUN_CONF_TMP
    done

    # remove logging from libhdhomerun library
    awk -v val="[libhdhomerun]" '$0 == val {flag=1; next} /^enable=|^logfile=|^#|^$/{if (flag==1) next} /.*/{flag=0; print}' $DVBHDHOMERUN_CONF_TMP >${DVBHDHOMERUN_CONF_TMP}-log
    mv ${DVBHDHOMERUN_CONF_TMP}-log $DVBHDHOMERUN_CONF_TMP
    echo "" >>$DVBHDHOMERUN_CONF_TMP
    # remove empty lines at the end of file
    sed -i -e ':a' -e '/^\n*$/{$d;N;};/\n$/ba' $DVBHDHOMERUN_CONF_TMP
    
    if [ "$LIBHDHOMERUN_LOG" = "true" ]; then
      cat >>$DVBHDHOMERUN_CONF_TMP << EOF

[libhdhomerun]
enable=true
logfile=/var/log/dvbhdhomerun_libhdhomerun.log

EOF
    fi

    md5_1=$(md5sum -b $DVBHDHOMERUN_CONF_TMP | awk '{print $1}')
    md5_2=$(md5sum -b $ADDON_HOME/dvbhdhomerun.conf | awk '{print $1}')
    if [ "$md5_1" != "$md5_2" ]; then
      # file changed - copy to addon home
      cp $DVBHDHOMERUN_CONF_TMP $ADDON_HOME/dvbhdhomerun.conf
    fi
  fi

  rm -f /tmp/dvbhdhomerun
  if [ -f $ADDON_HOME/dvbhdhomerun.conf ]; then
    ln -s $ADDON_HOME/dvbhdhomerun.conf /tmp/dvbhdhomerun
  fi

  [ -z "$PRE_WAIT" ] && PRE_WAIT=0
  PRE_WAIT=$(( $PRE_WAIT *1 ))
  [ -z "$POST_WAIT" ] && POST_WAIT=0
  POST_WAIT=$(( $POST_WAIT *1 ))

  logger -t HDHomeRun "### Pre wait for $PRE_WAIT sec ###"
  sleep $PRE_WAIT

  mkdir -p /var/log/
  rm -f /var/log/dvbhdhomerun.log

  userhdhomerun -f

  logger -t HDHomeRun "### Post wait for $POST_WAIT sec ###"
  sleep $POST_WAIT

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

logger -t HDHomeRun "### HDHomeRun ready ###"
