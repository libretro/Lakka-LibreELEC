################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
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

import os
import sys
import time
import xbmcaddon
import subprocess
from xml.dom.minidom import parse

sys.path.append('/usr/share/kodi/addons/service.libreelec.settings')

import oe

__addon__ = xbmcaddon.Addon();
__path__  = os.path.join(__addon__.getAddonInfo('path'), 'bin') + '/'

pauseXBMC = __addon__.getSetting("PAUSE_XBMC")

def pauseXbmc():
  if pauseXBMC == "true":
    xbmc.executebuiltin("PlayerControl(Stop)")
    xbmc.audioSuspend()
    xbmc.enableNavSounds(False)

def resumeXbmc():
  if pauseXBMC == "true":
    xbmc.audioResume()
    xbmc.enableNavSounds(True)

def startchrome(args):
  try:
    new_env = os.environ.copy()
    new_env['VAAPI_MODE'] = __addon__.getSetting('VAAPI_MODE')
    new_env['WINDOW_MODE'] = __addon__.getSetting('WINDOW_MODE')
    new_env['RASTER_MODE'] = __addon__.getSetting('RASTER_MODE')

    new_env['ALSA_DEVICE'] = ''
    if __addon__.getSetting('USE_CUST_AUDIODEVICE') == 'true':
      alsa_device = __addon__.getSetting('CUST_AUDIODEVICE_STR')
    else:
      alsa_device = getAudioDevice()
    if not alsa_device == None and not alsa_device == '':
      new_env['ALSA_DEVICE'] = alsa_device

    chrome_params = args + ' ' + \
                    __addon__.getSetting('HOMEPAGE')
    subprocess.call(__path__ + 'chrome-start ' + chrome_params, shell=True, env=new_env)
  except Exception, e:
    oe.dbg_log('chrome', unicode(e))

def isRuning(pname):
  tmp = os.popen("ps -Af").read()
  pcount = tmp.count(pname)
  if pcount > 0:
    return True
  return False

def getAudioDevice():
  try:
    dom = parse("/storage/.kodi/userdata/guisettings.xml")
    audiooutput=dom.getElementsByTagName('audiooutput')
    for node in audiooutput:
      dev = node.getElementsByTagName('audiodevice')[0].childNodes[0].nodeValue
    if dev.startswith("ALSA:"):
      dev = dev.split("ALSA:")[1]
      if dev == "@":
        return None
      if dev.startswith("@:"):
        dev = dev.split("@:")[1]
    else:
      # not ALSA
      return None
  except:
    return None
  if dev.startswith("CARD="):
    dev = "plughw:" + dev
  return dev

if (not __addon__.getSetting("firstrun")):
  __addon__.setSetting("firstrun", "1")
  __addon__.openSettings()

try:
  args = ' '.join(sys.argv[1:])
except:
  args = ""

if args == 'widevine':
  install_widevine()
elif args == 'flash':
  install_flash()
else:
  if not isRuning('chrome'):
    pauseXbmc()
    startchrome(args)
    while isRuning('chrome'):
      time.sleep(1)
    resumeXbmc()

