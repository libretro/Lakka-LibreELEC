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

ADDON_DIR="$HOME/.xbmc/addons/driver.dvb.sundtek"
ADDON_HOME="$HOME/.xbmc/userdata/addon_data/driver.dvb.sundtek"
ADDON_SETTINGS="$ADDON_HOME/settings.xml"
SUNDTEK_READY="/var/run/sundtek.ready"

mkdir -p $ADDON_HOME

if [ ! -f "$ADDON_HOME/sundtek.conf" ]; then
  cp $ADDON_DIR/config/* $ADDON_HOME/
fi

if [ ! -f "$ADDON_SETTINGS" ]; then
  cp $ADDON_DIR/settings-default.xml $ADDON_SETTINGS
fi

mkdir -p /var/config
cat "$ADDON_SETTINGS" | awk -F\" '{print $2"=\""$4"\""}' | sed '/^=/d' > /var/config/sundtek-addon.conf
. /var/config/sundtek-addon.conf

if [ "$AUTO_UPDATE" = "true" -a -f $ADDON_DIR/bin/mediasrv ]; then
  logger -t Sundtek "### Checking for new Sundtek binary installer ###"
  touch $ADDON_HOME/driver-version.txt
  wget -O /tmp/sundtek-driver-version.txt http://sundtek.de/media/latest.phtml
  md5_1=$(md5sum -b /tmp/sundtek-driver-version.txt | awk '{print $1}')
  md5_2=$(md5sum -b $ADDON_HOME/driver-version.txt | awk '{print $1}')
  if [ "$md5_1" != "$md5_2" ]; then
    logger -t Sundtek "### Updating Sundtek binary installer ###"
    rm -f $ADDON_DIR/bin/mediasrv
  fi

  rm -f /tmp/sundtek-driver-version.txt
fi

if [ ! -f $ADDON_DIR/bin/mediasrv ]; then
  logger -t Sundtek "### Downloading installer ###"
  cd $ADDON_DIR
  mkdir -p bin lib tmp
  cd tmp/

  ARCH=$(sed -n 's|.*\.\([^-]*\)-.*|\1|p' /etc/release | tr -d '\n')
  if [ "$ARCH" = "x86_64" ]; then
    INSTALLER_URL="http://sundtek.de/media/netinst/64bit/installer.tar.gz"
  elif [ "$ARCH" = "i386" ]; then
    INSTALLER_URL="http://sundtek.de/media/netinst/32bit/installer.tar.gz"
  elif [ "$ARCH" = "arm" ]; then
    INSTALLER_URL="http://sundtek.de/media/netinst/armsysvhf/installer.tar.gz"
  else
    logger -t Sundtek "### Unsupported architecture ###"
    cd ..
    rm -fr tmp/
    exit 1
  fi

  # test only !!!
  #INSTALLER_URL="http://sundtek.de/support/installer.tar.gz"
  
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
  cp ../driver-version.txt $ADDON_HOME/
  cd ..
  rm -fr tmp/
  logger -t Sundtek "### Installer finished ###"
fi

if [ ! -f $ADDON_HOME/driver-version.txt ]; then
  cp $ADDON_DIR/driver-version.txt $ADDON_HOME/
fi

# enable to install same version again
rm -f /storage/.xbmc/addons/packages/driver.dvb.sundtek-*

# add alias for /opt/bin/mediaclient
#alias_set="$(grep /opt/bin/mediaclient /storage/.profile 2>/dev/null)"
alias_set="$(grep libmediaclient.so /storage/.profile 2>/dev/null)"
if [ -z "$alias_set" ]; then
  echo "" >>/storage/.profile
  #echo "alias /opt/bin/mediaclient=/storage/.xbmc/addons/driver.dvb.sundtek/bin/mediaclient" >>/storage/.profile
  echo "[ -f /storage/.xbmc/addons/driver.dvb.sundtek/lib/libmediaclient.so ] && export LD_PRELOAD=/storage/.xbmc/addons/driver.dvb.sundtek/lib/libmediaclient.so" >>/storage/.profile
  echo "" >>/storage/.profile
fi

export LD_PRELOAD=$ADDON_DIR/lib/libmediaclient.so

if [ "$ANALOG_TV" = "true" -a ! -f "$ADDON_DIR/bin/plugins/lib/libavcodec.so.54.12.100" ]; then
	logger -t Sundtek "### Downloading missing ffmpeg libraries ###"
	cd $ADDON_DIR/bin
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
  rm -f $SUNDTEK_READY

  mediasrv --wait-for-devices -p $ADDON_DIR/bin -c $ADDON_HOME/sundtek.conf -d

  if [ -n "$NETWORK_TUNER_IP" -a "$NETWORK_TUNER_IP" != "0.0.0.0" ]; then
    logger -t Sundtek "### Trying to connect to Sundtek network device IP $NETWORK_TUNER_IP ###"
    mediaclient --mount=$NETWORK_TUNER_IP
  else
    logger -t Sundtek "### Trying to attach Sundtek device ###"
  fi

  # wait for device to get attached or connected
  for i in $(seq 1 240); do
    if [ -n "$NETWORK_TUNER_IP" -a -e /dev/dvb/adapter*/frontend* ]; then
      sh $ADDON_DIR/bin/device-attached.sh
    fi

    if [ -f $SUNDTEK_READY ]; then
      rm -f $SUNDTEK_READY
      logger -t Sundtek "### Sundtek ready ###"

      if [ -n $SETTLE_TIME -a $SETTLE_TIME -gt 0 ]; then
        logger -t Sundtek "### Settle for $SETTLE_TIME sec ###"
        sleep $SETTLE_TIME
      fi

      break
    elif [ "$i" = "240" ]; then
      logger -t Sundtek "### No Sundtek device attached or connected ###"
      return
    else
      usleep 500000
    fi
  done
 
  if [ "$ANALOG_TV" = "true" ]; then
  	logger -t Sundtek "### Switching to analog TV mode ###"  
    #rm -fr /dev/dvb/
    mediaclient --disable-dvb=/dev/dvb/adapter0
  fi

  if [ "$RUN_USER_SCRIPT" = "true" -a -f "$ADDON_HOME/userscript.sh" ]; then
    logger -t Sundtek "### Running user script $ADDON_HOME/userscript.sh ###"
    cat $ADDON_HOME/userscript.sh | dos2unix >/var/run/sundtek-userscript.sh
    sh /var/run/sundtek-userscript.sh
  fi
(
  # save adapter serial number in background
  sleep 5
  serial_number_old=$(cat $ADDON_HOME/adapters.txt 2>/dev/null)
  serial_number_new=$(mediaclient -e | awk '/device / {print $0} /ID:/ {print $2}')
  if [ "$serial_number_old" != "$serial_number_new" ]; then
    echo "$serial_number_new" >$ADDON_HOME/adapters.txt
  fi
)&
fi
