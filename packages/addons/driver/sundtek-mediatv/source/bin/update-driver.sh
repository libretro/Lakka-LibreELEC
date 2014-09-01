#!/bin/sh

################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
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

SUNDTEK_ADDON_DIR="$HOME/.xbmc/addons/driver.dvb.sundtek-mediatv"
SUNDTEK_ADDON_HOME="$HOME/.xbmc/userdata/addon_data/driver.dvb.sundtek-mediatv"
SUNDTEK_ADDON_SETTINGS="$SUNDTEK_ADDON_HOME/settings.xml"

logger -t Sundtek "### Starting updating driver ###"
xbmc-send -a "Notification(Sundtek, Starting updating driver, 2000)"

cd "$SUNDTEK_ADDON_DIR"
rm -fr tmp
mkdir tmp
cd tmp

ARCH=$(sed -n 's|.*\.\([^-]*\)-.*|\1|p' /etc/release | tr -d '\n')
if [ "$ARCH" = "x86_64" ]; then
  INSTALLER_URL="http://sundtek.de/media/netinst/64bit/installer.tar.gz"
elif [ "$ARCH" = "i386" ]; then
  INSTALLER_URL="http://sundtek.de/media/netinst/32bit/installer.tar.gz"
elif [ "$ARCH" = "arm" ]; then
  INSTALLER_URL="http://sundtek.de/media/netinst/armsysvhf/installer.tar.gz"
else
  logger -t Sundtek "### Unsupported architecture ###"
  xbmc-send -a "Notification(Sundtek, Unsupported architecture, 5000)"
  cd ..
  rm -fr tmp
  exit 1
fi

logger -t Sundtek "### Downloading driver archive for $ARCH ###"
xbmc-send -a "Notification(Sundtek, Downloading driver archive for $ARCH, 2000)"
wget -O installer.tar.gz $INSTALLER_URL
logger -t Sundtek "### Extracting archive ###"
xbmc-send -a "Notification(Sundtek, Extracting archive, 2000)"
tar -xzf installer.tar.gz
if [ $? -ne 0 ]; then
  logger -t Sundtek "### Archive damaged ###"
  xbmc-send -a "Notification(Sundtek, Archive damaged, 5000)"
  cd ..
  rm -fr tmp/
  exit 2
fi

killall -9 mediaclient.bin &>/dev/null                                          
killall -9 mediaclient &>/dev/null                                              
killall -9 mediasrv &>/dev/null 

# we run this via wrapper
mv opt/bin/mediaclient opt/bin/mediaclient.bin
chmod 755 opt/bin/*

cp -Pa opt/bin/* ../bin/
cp -Pa opt/lib/* ../lib/

cd ..
rm -fr tmp

logger -t Sundtek "### Driver update finished, please reboot ###"
xbmc-send -a "Notification(Sundtek, Driver update finished, 2000)"
xbmc-send -a "Notification(Sundtek, Please reboot, 5000)"
exit 0
