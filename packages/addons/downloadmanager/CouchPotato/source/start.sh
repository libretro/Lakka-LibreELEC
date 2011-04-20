#!/bin/sh

COUCHPOTATO_HOME="$HOME/.xbmc/userdata/addon_data/addon.downloadmanager.CouchPotato"
COUCHPOTATO_SETTINGS="$COUCHPOTATO_HOME/settings.xml"

mkdir -p /var/run
mkdir -p $COUCHPOTATO_HOME

python ./CouchPotato/CouchPotato.py -d \
				    --pidfile=/var/run/couchpotato.pid \
				    --datadir $COUCHPOTATO_HOME
