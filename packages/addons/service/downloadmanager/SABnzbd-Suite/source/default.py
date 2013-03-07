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
import time
import datetime

__scriptname__ = "SABnzbd Suite"
__author__     = "OpenELEC"
__url__        = "http://www.openelec.tv"
__settings__   = xbmcaddon.Addon(id='service.downloadmanager.SABnzbd-Suite')
__cwd__        = __settings__.getAddonInfo('path')
__start__      = xbmc.translatePath( os.path.join( __cwd__, 'bin', "SABnzbd-Suite.py") )
__stop__       = xbmc.translatePath( os.path.join( __cwd__, 'bin', "SABnzbd-Suite.stop") )

#make binary files executable in adson bin folder
subprocess.Popen("chmod -R +x " + __cwd__ + "/bin/*" , shell=True, close_fds=True)

checkInterval  = 120
timeout        = 20
wake_times     = ['01:00','03:00','05:00','07:00','09:00','11:00','13:00','15:00','17:00','19:00','21:00','23:00']

# Launch Suite
subprocess.call(['python',__start__])

# check for launching sabnzbd
sabNzbdLaunch = (__settings__.getSetting('SABNZBD_LAUNCH').lower() == 'true')

sys.path.append(os.path.join(__cwd__, 'pylib'))
from configobj import ConfigObj

if sabNzbdLaunch:
    # SABnzbd addresses and api key
    sabNzbdAddress    = '127.0.0.1:8081'
    sabNzbdConfigFile = '/storage/.xbmc/userdata/addon_data/service.downloadmanager.SABnzbd-Suite/sabnzbd.ini'
    sabConfiguration  = ConfigObj(sabNzbdConfigFile)
    sabNzbdApiKey     = sabConfiguration['misc']['api_key']
    sabNzbdUser       = sabConfiguration['misc']['username']
    sabNzbdPass       = sabConfiguration['misc']['password']
    sabNzbdQueue      = 'http://' + sabNzbdAddress + '/api?mode=queue&output=xml&apikey=' + sabNzbdApiKey + '&ma_username=' + sabNzbdUser + '&ma_password=' + sabNzbdPass

    # start checking SABnzbd for activity and prevent sleeping if necessary
    socket.setdefaulttimeout(timeout)
    
    # perform some initial checks and log essential settings
    shouldKeepAwake = (__settings__.getSetting('SABNZBD_KEEP_AWAKE').lower() == 'true')
    wakePeriodically = (__settings__.getSetting('SABNZBD_PERIODIC_WAKE').lower() == 'true')
    wakeHourIdx = int(__settings__.getSetting('SABNZBD_WAKE_AT'))
    if shouldKeepAwake:
        xbmc.log('SABnzbd-Suite: will prevent idle sleep/shutdown while downloading')
    if wakePeriodically:
        xbmc.log('SABnzbd-Suite: will try to wake system daily at ' + wake_times[wakeHourIdx])


while (not xbmc.abortRequested):

    if sabNzbdLaunch:
        # reread setting in case it has changed
        shouldKeepAwake = (__settings__.getSetting('SABNZBD_KEEP_AWAKE').lower() == 'true')
        wakePeriodically = (__settings__.getSetting('SABNZBD_PERIODIC_WAKE').lower() == 'true')
        wakeHourIdx = int(__settings__.getSetting('SABNZBD_WAKE_AT'))

        # check if SABnzbd is downloading
        if shouldKeepAwake:
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
            if sabIsActive:
                response = xbmc.executehttpapi("GetGUISetting(0;powermanagement.shutdowntime)").replace('<li>','')
                shutdownTime = int(response) * 60
                idleTime = xbmc.getGlobalIdleTime()
                timeToShutdown = shutdownTime - idleTime

                if (timeToShutdown <= checkInterval - timeout):
                    xbmc.log('SABnzbd-Suite: still downloading. Resetting XBMC idle timer.')
                    xbmc.executehttpapi("SendKey(0xF000)")

        # calculate and set the time to wake up at (if any)
        if wakePeriodically:
            wakeHour = wakeHourIdx * 2 + 1
            timeOfDay = datetime.time(hour=wakeHour)
            now = datetime.datetime.now()
            wakeTime = now.combine(now.date(),timeOfDay)
            if now.time() > timeOfDay:
                wakeTime += datetime.timedelta(days=1)
            secondsSinceEpoch = time.mktime(wakeTime.timetuple())
            open("/sys/class/rtc/rtc0/wakealarm", "w").write("0")
            open("/sys/class/rtc/rtc0/wakealarm", "w").write(str(secondsSinceEpoch))

    time.sleep(0.250)

subprocess.Popen(__stop__, shell=True, close_fds=True)

