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

COUCHPOTATO_HOME="$HOME/.xbmc/userdata/addon_data/addon.downloadmanager.CouchPotato"
COUCHPOTATO_SETTINGS="$COUCHPOTATO_HOME/settings.xml"

mkdir -p /var/run
mkdir -p $COUCHPOTATO_HOME

python ./CouchPotato/CouchPotato.py -d \
				    --pidfile=/var/run/couchpotato.pid \
				    --datadir $COUCHPOTATO_HOME
