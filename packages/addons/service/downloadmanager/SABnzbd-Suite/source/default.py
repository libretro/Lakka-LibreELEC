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

import os
import sys
import xbmcaddon
import time
import subprocess
import xbmc
import urllib2
import socket
from configobj import ConfigObj

__scriptname__ = "SABnzbd Suite"
__author__     = "OpenELEC"
__url__        = "http://www.openelec.tv"
__settings__   = xbmcaddon.Addon(id='service.downloadmanager.SABnzbd-Suite')
__cwd__        = __settings__.getAddonInfo('path')
__path__       = xbmc.translatePath( os.path.join( __cwd__, 'bin', "SABnzbd-Suite.py") )

checkInterval  = 120
timeout        = 20


# Launch Suite
subprocess.call(['python',__path__])


# SABnzbd addresses and api key
sabNzbdAddress    = '127.0.0.1:8081'
sabNzbdConfigFile = '/storage/.xbmc/userdata/addon_data/service.downloadmanager.SABnzbd-Suite/sabnzbd.ini'
sabConfiguration  = ConfigObj(sabNzbdConfigFile)
sabNzbdApiKey     = sabConfiguration['misc']['api_key']
sabNzbdUser       = sabConfiguration['misc']['username']
sabNzbdPass       = sabConfiguration['misc']['password']
sabNzbdQueue      = 'http://' + sabNzbdAddress + '/sabnzbd/api?mode=queue&output=xml&apikey=' + sabNzbdApiKey + '&ma_username=' + sabNzbdUser + '&ma_password=' + sabNzbdUser

# start checking SABnzbd for activity and prevent sleeping if necessary
socket.setdefaulttimeout(timeout)

shouldKeepAwake = __settings__.getSetting('SABNZBD_KEEP_AWAKE')
if shouldKeepAwake:
    xbmc.log('SABnzbd-Suite: will prevent idle sleep/shutdown while downloading')

while (not xbmc.abortRequested):
    
    # reread setting in case it has changed
    shouldKeepAwake = __settings__.getSetting('SABNZBD_KEEP_AWAKE')
    
    # check if SABnzbd is downloading
    sabIsActive = False
    req = urllib2.Request(sabNzbdQueue)
    try: handle = urllib2.urlopen(req)
    except IOError, e:
        xbmc.log('SABnzbd-Suite: could not determine SABnzbds status', level=xbmc.LOGERROR)
    else:
        queue = handle.read()
        handle.close()
        sabIsActive = (queue.find('<status>Downloading</status>') >= 0)
    
    # reset idle timer when we're close to idle sleep/shutdown
    if (shouldKeepAwake and sabIsActive):
        response = xbmc.executehttpapi("GetGUISetting(0;powermanagement.shutdowntime)").replace('<li>','')
        shutdownTime = int(response) * 60
        idleTime = xbmc.getGlobalIdleTime()
        timeToShutdown = shutdownTime - idleTime
        
        if (sabIsActive and timeToShutdown <= checkInterval - timeout):
            xbmc.log('SABnzbd-Suite: still downloading. Resetting XBMC idle timer.')
            xbmc.executehttpapi("SendKey(0xF000)")
        
    xbmc.sleep(checkInterval * 1000)