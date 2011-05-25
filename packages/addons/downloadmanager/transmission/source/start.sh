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

XBMC_PID=$1
APP=$2
SCRIPT_DIR=$(dirname `readlink -f $0`)
ADDON_HOME="$HOME/.xbmc/userdata/addon_data/addon.downloadmanager.transmission"
PATH="${PATH}:${SCRIPT_DIR}/bin"
LOG_FILE="${ADDON_HOME}/service.log"

cleanup() {
  local EXIT_STATUS=$1
  if [ -n "${EXIT_STATUS}" ];then
    EXIT_STATUS=0
  fi
  kill -15 "${APP_PID}"
  exit $EXIT_STATUS;
}

# trap signals for clean shutdown
  trap cleanup 1 2 3 15

launch_app() {
  local PID
  eval "${APP} ${TRANSMISSION_ARG} &>${LOG_FILE} &"
  APP_PID=$!
}

pid_is_running() {
  local PID=${1}
  for IPID in `ps -o pid | sed 's/[A-Za-z]//g' | sed 's/\ //g'`;do
    if [ ${IPID} -eq ${PID} ];then
      return 0
    fi
  done
  return 1
}

app_prep() {

export TRANSMISSION_WEB_HOME="$SCRIPT_DIR/web"

OPENELEC_SETTINGS="$ADDON_HOME/settings.xml"

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
TRANSMISSION_ARG="$TRANSMISSION_ARG -f"

if [ "$TRANSMISSION_AUTH" = "true" ]; then
  TRANSMISSION_ARG="$TRANSMISSION_ARG -t"
  TRANSMISSION_ARG="$TRANSMISSION_ARG -u $TRANSMISSION_USER"
  TRANSMISSION_ARG="$TRANSMISSION_ARG -v $TRANSMISSION_PWD"
else
  TRANSMISSION_ARG="$TRANSMISSION_ARG -T"
fi

}

main() {
	app_prep
	launch_app "${APP}"
	pid_is_running "${XBMC_PID}"
	XBMC_RUNNING=$?
	pid_is_running "${APP_PID}"
	APP_RUNNING=$?

	while [ $XBMC_RUNNING -eq 0 -a ${APP_RUNNING} -eq 0 ]; do
		sleep 1
		pid_is_running "${XBMC_PID}"
		XBMC_RUNNING=$?
		pid_is_running "${APP_PID}"
		APP_RUNNING=$?
	done
}

main
cleanup
