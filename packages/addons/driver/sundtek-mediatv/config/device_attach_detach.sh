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
#ATTACH_DETACH_LOG="/dev/null"
SUNDTEK_COUNTER_FILE="/var/run/sundtek-mediatv.counter"

wait_process() {
  while [ -n "$(pidof $1)" ]; do
    usleep 200000
  done
}

  echo "============================================================================" >>$ATTACH_DETACH_LOG
  echo "Date: `date`"               >>$ATTACH_DETACH_LOG
  echo "Params: action=$1 devid=$2" >>$ATTACH_DETACH_LOG

  . $SUNDTEK_COUNTER_FILE

  case "$1" in
    attach)
      let SUNDTEK_COUNTER++
      echo "SUNDTEK_COUNTER=$SUNDTEK_COUNTER" >$SUNDTEK_COUNTER_FILE
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ADDON_DIR/lib
      export LD_PRELOAD=$LD_PRELOAD:$ADDON_DIR/lib/libmediaclient.so

(
      # save adapter serial number (in background)
      sleep 2
      serial_number=` mediaclient -e | awk '/device / {printf("%s\n", $0)} /ID:/ {printf("  serial: %s\n\n", $2)}'`
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
      let SUNDTEK_COUNTER--
      echo "SUNDTEK_COUNTER=$SUNDTEK_COUNTER" >$SUNDTEK_COUNTER_FILE
      if [ "$SUNDTEK_COUNTER" = "0" ] ; then
        export LD_LIBRARY_PATH=${LD_LIBRARY_PATH//:$ADDON_DIR\/lib/}
        export LD_PRELOAD=${LD_PRELOAD//:$ADDON_DIR\/lib\/libmediaclient.so/}
      else
        export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ADDON_DIR/lib
        export LD_PRELOAD=$LD_PRELOAD:$ADDON_DIR/lib/libmediaclient.so
      fi
      ;;

    *)
      exit $NA
      ;;
  esac

  echo "SUNDTEK_COUNTER=$SUNDTEK_COUNTER" >>$ATTACH_DETACH_LOG
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
