#!/bin/sh
#
# first argument: attach/detach
# second argument (DEVID - sequence number of device): 0/1/2/...

. /etc/profile

# which daemon to restart
TVHEADEND=1
MUMUDVB=0

ADDON_DIR="/storage/.xbmc/addons/driver.dvb.sundtek-mediatv"
ADDON_HOME="/storage/.xbmc/userdata/addon_data/driver.dvb.sundtek-mediatv"
ATTACH_DETACH_LOG="$ADDON_HOME/attach_detach.log"

wait_process() {
  while [ -n "$(pidof $1)" ]; do
    usleep 200000
  done
}

  echo "============================================================================" >>$ATTACH_DETACH_LOG
  echo "Date: `date`"               >>$ATTACH_DETACH_LOG
  echo "Params: action=$1 devid=$2" >>$ATTACH_DETACH_LOG

  case "$1" in
    attach)
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ADDON_DIR/lib
      export LD_PRELOAD=$LD_PRELOAD:$ADDON_DIR/lib/libmediaclient.so

(
      # save adapter serial number (in background)
      sleep 2
      serial_number=`mediaclient -e | awk '/ID:/ {print $2}'`
      if [ ! -f $ADDON_HOME/adapter_serial_number.txt ]; then
        echo -n "$serial_number" >$ADDON_HOME/adapter_serial_number.txt
      else
        serial_number_read=`cat $ADDON_HOME/adapter_serial_number.txt`
        if [ "$serial_number_read" != "$serial_number" ]; then
          echo -n "$serial_number" >$ADDON_HOME/adapter_serial_number.txt
        fi
      fi
)&
      ;;

    detach)
      export LD_LIBRARY_PATH=${LD_LIBRARY_PATH//:$ADDON_DIR\/lib/}
      export LD_PRELOAD=${LD_PRELOAD//:$ADDON_DIR\/lib\/libmediaclient.so/}
      ;;

    *)
      exit $NA
      ;;
  esac

  echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >>$ATTACH_DETACH_LOG
  echo "LD_PRELOAD=$LD_PRELOAD"           >>$ATTACH_DETACH_LOG

  if [ "$TVHEADEND" = "1" -a -n "$(pidof tvheadend)" ]; then
    echo "Restarting TVheadend..."  >>$ATTACH_DETACH_LOG
    sh /storage/.xbmc/addons/service.multimedia.hts-tvheadend/sleep.d/tvheadend.power suspend
    wait_process tvheadend
    sh /storage/.xbmc/addons/service.multimedia.hts-tvheadend/sleep.d/tvheadend.power resume
  fi

  if [ "$MUMUDVB" = "1" -a -n "$(pidof mumudvb)" ]; then
    echo "Restarting MuMuDVB..."  >>$ATTACH_DETACH_LOG
    sh /storage/.xbmc/addons/service.multimedia.mumudvb/sleep.d/mumudvb.power suspend
    wait_process mumudvb
    sh /storage/.xbmc/addons/service.multimedia.mumudvb/sleep.d/mumudvb.power resume
  fi
