################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################
import xbmc
import xbmcvfs
import xbmcaddon
from os import system


class MyMonitor(xbmc.Monitor):
    def __init__(self, *args, **kwargs):
        xbmc.Monitor.__init__(self)
    
    def onSettingsChanged(self):
        writeconfig()

            
# addon
__addon__ = xbmcaddon.Addon(id='service.net-snmp')
__addonpath__ = xbmc.translatePath(__addon__.getAddonInfo('path'))
__addonhome__ = xbmc.translatePath(__addon__.getAddonInfo('profile'))
if not xbmcvfs.exists(xbmc.translatePath(__addonhome__ + 'share/snmp/')):
    xbmcvfs.mkdirs(xbmc.translatePath(__addonhome__ + 'share/snmp/'))
config = xbmc.translatePath(__addonhome__ + 'share/snmp/snmpd.conf')
persistent = xbmc.translatePath(__addonhome__ + 'snmpd.conf')


def writeconfig():
    system("systemctl stop service.net-snmp.service")
    community = __addon__.getSetting("COMMUNITY")
    location = __addon__.getSetting("LOCATION")
    contact = __addon__.getSetting("CONTACT")
    snmpversion = __addon__.getSetting("SNMPVERSION")
    
    if xbmcvfs.exists(persistent):
            xbmcvfs.delete(persistent)
    
    file = xbmcvfs.File(config, 'w')
    file.write('com2sec local default {}\n'.format(community))
    file.write('group localgroup {} local\n'.format(snmpversion))
    file.write('access localgroup "" any noauth exact all all none\n')
    file.write('view all included .1 80\n')
    file.write('syslocation {}\n'.format(location))
    file.write('syscontact {}\n'.format(contact))
    file.write('dontLogTCPWrappersConnects yes\n')
    file.close()
    
    if snmpversion == "v3":
        snmppassword = __addon__.getSetting("SNMPPASSWORD")
        snmpuser = __addon__.getSetting("SNMPUSER")
        system("net-snmp-config --create-snmpv3-user -a {0} {1}".format(snmppassword,snmpuser))
    
    system("systemctl start service.net-snmp.service")


if not xbmcvfs.exists(config):
    writeconfig()

monitor = MyMonitor()
while not monitor.abortRequested():
    if monitor.waitForAbort():
        break

