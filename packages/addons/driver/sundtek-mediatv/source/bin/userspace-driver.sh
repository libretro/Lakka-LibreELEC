#!/bin/sh

################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2013 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

. /etc/profile

# start locking mechanism - allows only one instance to be run at a time
SUNDTEK_LOCKFILE="/var/lock/userspace-driver-sundtek.lck"
SUNDTEK_LOCKFD=99
# obtain an exclusive lock
exlock() { eval "exec $SUNDTEK_LOCKFD>\"$SUNDTEK_LOCKFILE\""; flock -x $SUNDTEK_LOCKFD; }
# drop a lock
unlock() { flock -u $SUNDTEK_LOCKFD; flock -xn $SUNDTEK_LOCKFD && rm -f "$SUNDTEK_LOCKFILE"; }
# end locking mechanism

# exclusive lock
exlock

net_tuner_num_fix() {
  local num=$1

  [ -z "$num" ] && num=1
  num=$(( $num *1 ))
  [ $num -lt 1 ] && num=1
  num=$(( $num -1 ))
  echo $num
}

SUNDTEK_ADDON_DIR="$HOME/.xbmc/addons/driver.dvb.sundtek-mediatv"
SUNDTEK_ADDON_HOME="$HOME/.xbmc/userdata/addon_data/driver.dvb.sundtek-mediatv"
SUNDTEK_ADDON_SETTINGS="$SUNDTEK_ADDON_HOME/settings.xml"

mkdir -p $SUNDTEK_ADDON_HOME

if [ ! -f "$SUNDTEK_ADDON_HOME/sundtek.conf" ]; then
  cp $SUNDTEK_ADDON_DIR/config/* $SUNDTEK_ADDON_HOME/
else
  # in case of missing entries in addon home's sundtek.conf
  entry_set="$(grep use_hwpidfilter $SUNDTEK_ADDON_HOME/sundtek.conf 2>/dev/null)"
  if [ -z "$entry_set" ]; then
    sed -i 's|^device_attach=.*|# device_attach not used anymore\n\n# enable HW PID filter\nuse_hwpidfilter=off\n\n# enable listening on network\nenablenetwork=off|g' $SUNDTEK_ADDON_HOME/sundtek.conf
    sed -i 's|^#first_adapter=.*|first_adapter=0|g' $SUNDTEK_ADDON_HOME/sundtek.conf

    sed -i 's|.*network tuner IP address (OpenELEC specific).*||g' $SUNDTEK_ADDON_HOME/sundtek.conf
    sed -i 's|.*network_tuner_ip=.*||g' $SUNDTEK_ADDON_HOME/sundtek.conf
  fi
fi

if [ ! -f "$SUNDTEK_ADDON_SETTINGS" ]; then
  cp $SUNDTEK_ADDON_DIR/settings-default.xml $SUNDTEK_ADDON_SETTINGS
fi

[ ! -f $SUNDTEK_ADDON_HOME/rc_key_enter.map ] && mv $SUNDTEK_ADDON_HOME/rc_key_enter $SUNDTEK_ADDON_HOME/rc_key_enter.map
[ ! -f $SUNDTEK_ADDON_HOME/rc_key_ok.map ] && mv $SUNDTEK_ADDON_HOME/rc_key_ok $SUNDTEK_ADDON_HOME/rc_key_ok.map

mkdir -p /var/config
cat "$SUNDTEK_ADDON_SETTINGS" | awk -F\" '{print $2"=\""$4"\""}' | sed '/^=/d' > /var/config/sundtek-addon.conf
. /var/config/sundtek-addon.conf

if [ "$AUTO_UPDATE" = "true" -a -f $SUNDTEK_ADDON_DIR/bin/mediasrv ]; then
  logger -t Sundtek "### Checking for new Sundtek binary installer ###"
  touch $SUNDTEK_ADDON_HOME/driver-version.txt
  wget -O /tmp/sundtek-driver-version.txt http://sundtek.de/media/latest.phtml
  md5_1=$(md5sum -b /tmp/sundtek-driver-version.txt | awk '{print $1}')
  md5_2=$(md5sum -b $SUNDTEK_ADDON_HOME/driver-version.txt | awk '{print $1}')
  if [ "$md5_1" != "$md5_2" ]; then
    logger -t Sundtek "### Updating Sundtek binary installer ###"
    rm -f $SUNDTEK_ADDON_DIR/bin/mediasrv
  fi

  rm -f /tmp/sundtek-driver-version.txt
fi

if [ ! -f $SUNDTEK_ADDON_DIR/bin/mediasrv ]; then
  # remove renamed addon if exist
  rm -fr "$HOME/.xbmc/addons/driver.dvb.sundtek"
  rm -fr "$HOME/userdata/addon_data/driver.dvb.sundtek"

  logger -t Sundtek "### Downloading installer ###"
  cd $SUNDTEK_ADDON_DIR
  mkdir -p bin lib tmp
  cd tmp/

  ARCH=$(sed -n 's|.*\.\([^-]*\)-.*|\1|p' /etc/release | tr -d '\n')
  if [ "$ARCH" = "x86_64" ]; then
    INSTALLER_URL="http://sundtek.de/media/netinst/64bit/installer.tar.gz"
  elif [ "$ARCH" = "i386" ]; then
    INSTALLER_URL="http://sundtek.de/media/netinst/32bit/installer.tar.gz"
  elif [ "$ARCH" = "arm" ]; then
    INSTALLER_URL="http://sundtek.de/media/netinst/armsysvhf/installer.tar.gz"

    # enable HW PID filter on RPi by default
    sed -i 's|^use_hwpidfilter=.*|use_hwpidfilter=on|g' $SUNDTEK_ADDON_DIR/config/sundtek.conf
    sed -i 's|^use_hwpidfilter=.*|use_hwpidfilter=on|g' $SUNDTEK_ADDON_HOME/sundtek.conf
    sed -i 's|.*id="ENABLE_HW_PID_FILTER".*|<setting id="ENABLE_HW_PID_FILTER" value="true" />|' $SUNDTEK_ADDON_DIR/settings-default.xml
    sed -i 's|.*id="ENABLE_HW_PID_FILTER".*|<setting id="ENABLE_HW_PID_FILTER" value="true" />|' $SUNDTEK_ADDON_SETTINGS
  else
    logger -t Sundtek "### Unsupported architecture ###"
    cd ..
    rm -fr tmp/
    exit 1
  fi

  wget -O installer.tar.gz $INSTALLER_URL
  wget -O ../driver-version.txt http://sundtek.de/media/latest.phtml
  logger -t Sundtek "### Extracting installer ###"
  tar -xzf installer.tar.gz
  if [ $? -ne 0 ]; then
    logger -t Sundtek "### Installer damaged ###"
    cd ..
    rm -fr tmp/
    exit 2
  fi

  cp -Pa opt/bin/* ../bin/
  cp -Pa opt/lib/* ../lib/
  cp ../driver-version.txt $SUNDTEK_ADDON_HOME/
  cd ..
  rm -fr tmp/
  logger -t Sundtek "### Installer finished ###"

  cat "$SUNDTEK_ADDON_SETTINGS" | awk -F\" '{print $2"=\""$4"\""}' | sed '/^=/d' > /var/config/sundtek-addon.conf
  . /var/config/sundtek-addon.conf
fi

if [ ! -f $SUNDTEK_ADDON_HOME/driver-version.txt ]; then
  cp $SUNDTEK_ADDON_DIR/driver-version.txt $SUNDTEK_ADDON_HOME/
fi

# enable to install same addon package version again
#rm -f /storage/.xbmc/addons/packages/driver.dvb.sundtek*

# add alias for /opt/bin/mediaclient
alias_set="$(grep libmediaclient.so /storage/.profile 2>/dev/null)"
if [ -z "$alias_set" ]; then
  echo "" >>/storage/.profile
  echo "[ -f /storage/.xbmc/addons/driver.dvb.sundtek-mediatv/lib/libmediaclient.so ] && export LD_PRELOAD=/storage/.xbmc/addons/driver.dvb.sundtek-mediatv/lib/libmediaclient.so" >>/storage/.profile
  echo "" >>/storage/.profile
else
  # fix name
  sed -i 's|/driver.dvb.sundtek/|/driver.dvb.sundtek-mediatv/|g' /storage/.profile
fi

export LD_PRELOAD=$SUNDTEK_ADDON_DIR/lib/libmediaclient.so

if [ "$ANALOG_TV" = "true" -a ! -f "$SUNDTEK_ADDON_DIR/bin/plugins/lib/libavcodec.so.54.12.100" ]; then
  logger -t Sundtek "### Downloading missing ffmpeg libraries ###"
  cd $SUNDTEK_ADDON_DIR/bin
  mkdir -p plugins/
  cd plugins/

  ARCH=$(sed -n 's|.*\.\([^-]*\)-.*|\1|p' /etc/release | tr -d '\n')
  wget -O sundtek-ffmpeg-analog_tv-lib.tgz http://dl.dropbox.com/u/8224157/public/sundtek/sundtek-ffmpeg-analog_tv-lib-$ARCH.tgz

  logger -t Sundtek "### Extracting ffmpeg libraries ###"
  tar -xzf sundtek-ffmpeg-analog_tv-lib.tgz
  if [ $? -ne 0 ]; then
    logger -t Sundtek "### Ffmpeg library archive damaged ###"
    rm -f sundtek-ffmpeg-analog_tv-lib.tgz
    exit 2
  fi

  rm -f sundtek-ffmpeg-analog_tv-lib.tgz
fi

if [ -z "$(pidof mediasrv)" ]; then
  rm -f /var/log/mediasrv.log
  rm -f /var/log/mediaclient.log

  SUNDTEK_CONF_TMP=/tmp/sundtek.conf
  cp $SUNDTEK_ADDON_HOME/sundtek.conf $SUNDTEK_CONF_TMP

  [ -z "$LOWEST_ADAPTER_NUM" ] && LOWEST_ADAPTER_NUM=0
  sed -i "s|^first_adapter=.*|first_adapter=$LOWEST_ADAPTER_NUM|g" $SUNDTEK_CONF_TMP

  # enable HW PID filter
  if [ "$ENABLE_HW_PID_FILTER" = "true" ]; then
    sed -i 's|^use_hwpidfilter=.*|use_hwpidfilter=on|g' $SUNDTEK_CONF_TMP
  else
    sed -i 's|^use_hwpidfilter=.*|use_hwpidfilter=off|g' $SUNDTEK_CONF_TMP
  fi

  # enable IR receiver
  if [ "$ENABLE_IR_RECEIVER" = "true" ]; then
    sed -i 's|^ir_disabled=.*|ir_disabled=0|g' $SUNDTEK_CONF_TMP
  else
    sed -i 's|^ir_disabled=.*|ir_disabled=1|g' $SUNDTEK_CONF_TMP
  fi

  if [ "$ALLOW_NET_USE" = "true" ]; then
    sed -i 's|^enablenetwork=.*|enablenetwork=on|g' $SUNDTEK_CONF_TMP
  else
    sed -i 's|^enablenetwork=.*|enablenetwork=off|g' $SUNDTEK_CONF_TMP
  fi

  [ "$DEVICE1_IP" = "0.0.0.0" ] && DEVICE1_IP=""
  [ "$DEVICE2_IP" = "0.0.0.0" ] && DEVICE2_IP=""
  [ "$DEVICE3_IP" = "0.0.0.0" ] && DEVICE3_IP=""
  [ "$DEVICE4_IP" = "0.0.0.0" ] && DEVICE4_IP=""
  [ "$DEVICE5_IP" = "0.0.0.0" ] && DEVICE5_IP=""
  DEVICE1_NUM=$(net_tuner_num_fix $DEVICE1_NUM)
  DEVICE2_NUM=$(net_tuner_num_fix $DEVICE2_NUM)
  DEVICE3_NUM=$(net_tuner_num_fix $DEVICE3_NUM)
  DEVICE4_NUM=$(net_tuner_num_fix $DEVICE4_NUM)
  DEVICE5_NUM=$(net_tuner_num_fix $DEVICE5_NUM)

  if [ "$USE_NET_TUNERS" = "true" -a -n "$DEVICE1_IP" ]; then
    # delete all network tuner entries
    awk '/^\[NETWORK\]/{flag=1; next} /^device=|^#|^$/{if (flag==1) next} /.*/{flag=0; print}' $SUNDTEK_CONF_TMP >${SUNDTEK_CONF_TMP}-net
    mv ${SUNDTEK_CONF_TMP}-net $SUNDTEK_CONF_TMP
    echo "" >>$SUNDTEK_CONF_TMP
    # remove empty lines at the end of file
    sed -i -e ':a' -e '/^\n*$/{$d;N;};/\n$/ba' $SUNDTEK_CONF_TMP
    # add entries
    echo -e "\n[NETWORK]" >>$SUNDTEK_CONF_TMP
    for dev in $(seq 0 $DEVICE1_NUM); do
      echo "device=$DEVICE1_IP:$dev" >>$SUNDTEK_CONF_TMP
    done
    if [ -n "$DEVICE2_IP" ]; then
      for dev in $(seq 0 $DEVICE2_NUM); do
        echo "device=$DEVICE2_IP:$dev" >>$SUNDTEK_CONF_TMP
      done
      if [ -n "$DEVICE3_IP" ]; then
        for dev in $(seq 0 $DEVICE3_NUM); do
          echo "device=$DEVICE3_IP:$dev" >>$SUNDTEK_CONF_TMP
        done
        if [ -n "$DEVICE4_IP" ]; then
          for dev in $(seq 0 $DEVICE4_NUM); do
            echo "device=$DEVICE4_IP:$dev" >>$SUNDTEK_CONF_TMP
          done
          if [ -n "$DEVICE5_IP" ]; then
            for dev in $(seq 0 $DEVICE5_NUM); do
              echo "device=$DEVICE5_IP:$dev" >>$SUNDTEK_CONF_TMP
            done
          fi
        fi
      fi
    fi
  else
    # delete all network tuner entries
    awk '/^\[NETWORK\]/{flag=1; next} /^device=|^#|^$/{if (flag==1) next} /.*/{flag=0; print}' $SUNDTEK_CONF_TMP >${SUNDTEK_CONF_TMP}-net
    mv ${SUNDTEK_CONF_TMP}-net $SUNDTEK_CONF_TMP
    echo "" >>$SUNDTEK_CONF_TMP
    # remove empty lines at the end of file
    sed -i -e ':a' -e '/^\n*$/{$d;N;};/\n$/ba' $SUNDTEK_CONF_TMP
  fi

  if [ "$ENABLE_TUNER_TYPES" = "true" ]; then
    # get tuner serial numbers
    SERIALS=$(cat /var/config/sundtek-addon.conf | sed -n 's|^ATTACHED_TUNER_\(.*\)_DVBMODE=.*|\1|gp' | sort | uniq)
    . /var/config/sundtek-addon.conf

    for SERIAL in $SERIALS; do
      DVBMODE=$(eval echo \$ATTACHED_TUNER_${SERIAL}_DVBMODE)
      IRPROT=$(eval echo \$ATTACHED_TUNER_${SERIAL}_IRPROT)
      KEYMAP=$(eval echo \$ATTACHED_TUNER_${SERIAL}_KEYMAP)

      if [ "$DVBMODE" = "DVB-T" ]; then
        # only set DVB-T because default is DVB-C (and DVB-S is not set either)
        DVBMODE="DVBT"
      else
        DVBMODE=""
      fi

      [ "$IRPROT" = "NEC" -o "$IRPROT" = "auto" ] && IRPROT=""

      [ ! -f $KEYMAP ] && KEYMAP=""

      # remove setttings for this tuner
      awk -v val="[$SERIAL]" '$0 == val {flag=1; next} /^ir_protocol=|^rcmap=|^initial_dvb_mode=|^#|^$/{if (flag==1) next} /.*/{flag=0; print}' $SUNDTEK_CONF_TMP >${SUNDTEK_CONF_TMP}-types
      mv ${SUNDTEK_CONF_TMP}-types $SUNDTEK_CONF_TMP
      echo "" >>$SUNDTEK_CONF_TMP
      # remove empty lines at the end of file
      sed -i -e ':a' -e '/^\n*$/{$d;N;};/\n$/ba' $SUNDTEK_CONF_TMP

      ADDNEW=true
      if [ -n "$DVBMODE" ]; then
        [ $ADDNEW = true ] && ADDNEW=false && echo -e "\n[$SERIAL]" >>$SUNDTEK_CONF_TMP
        echo "initial_dvb_mode=$DVBMODE" >>$SUNDTEK_CONF_TMP
      fi
      if [ -n "$IRPROT" ]; then
        [ $ADDNEW = true ] && ADDNEW=false && echo -e "\n[$SERIAL]" >>$SUNDTEK_CONF_TMP
        echo "ir_protocol=$IRPROT" >>$SUNDTEK_CONF_TMP
      fi
      if [ -n "$KEYMAP" ]; then
        [ $ADDNEW = true ] && ADDNEW=false && echo -e "\n[$SERIAL]" >>$SUNDTEK_CONF_TMP
        echo "rcmap=$KEYMAP" >>$SUNDTEK_CONF_TMP
      fi

      echo "" >>$SUNDTEK_CONF_TMP
    done
  fi

  md5_1=$(md5sum -b $SUNDTEK_CONF_TMP | awk '{print $1}')
  md5_2=$(md5sum -b $SUNDTEK_ADDON_HOME/sundtek.conf | awk '{print $1}')
  if [ "$md5_1" != "$md5_2" ]; then
    # file changed - copy to addon home
    cp $SUNDTEK_CONF_TMP $SUNDTEK_ADDON_HOME/sundtek.conf
  fi

  mediasrv --wait-for-devices -p $SUNDTEK_ADDON_DIR/bin -c $SUNDTEK_ADDON_HOME/sundtek.conf -d

  # wait few seconds
  [ -z "$SETTLE_TIME" ] && SETTLE_TIME=0
  SETTLE_TIME=$(( $SETTLE_TIME *1 ))
  if [ $SETTLE_TIME -gt 0 ]; then
    logger -t Sundtek "### Settle for $SETTLE_TIME sec ###"
    sleep $SETTLE_TIME
  fi

  if [ "$ANALOG_TV" = "true" ]; then
    logger -t Sundtek "### Switching to analog TV mode ###"
    #rm -fr /dev/dvb/
    mediaclient --disable-dvb=/dev/dvb/adapter0
  fi

  if [ "$RUN_USER_SCRIPT" = "true" -a -f "$SUNDTEK_ADDON_HOME/userscript.sh" ]; then
    logger -t Sundtek "### Running user script $SUNDTEK_ADDON_HOME/userscript.sh ###"
    cat $SUNDTEK_ADDON_HOME/userscript.sh | dos2unix >/var/run/sundtek-userscript.sh
    sh /var/run/sundtek-userscript.sh
  fi
(
  # save adapter serial number in background
  sleep 5
  serial_number_old=$(cat $SUNDTEK_ADDON_HOME/adapters.txt 2>/dev/null)
  serial_number_new=$(mediaclient -e | awk '/device / {print $0} /ID:/ {print $2}')
  if [ "$serial_number_old" != "$serial_number_new" ]; then
    echo "$serial_number_new" >$SUNDTEK_ADDON_HOME/adapters.txt
  fi
)&
fi

logger -t Sundtek "### Sundtek ready ###"

# unlock the lock
unlock
