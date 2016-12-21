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
import time
import xbmcaddon
import subprocess
from xml.dom.minidom import parse

sys.path.append('/usr/share/kodi/addons/service.libreelec.settings')

import oe

__addon__ = xbmcaddon.Addon();
__path__  = os.path.join(__addon__.getAddonInfo('path'), 'bin') + '/'

pauseXBMC = __addon__.getSetting("PAUSE_XBMC")

# widevine and flash stuff
def install_flash():
  __url__   = 'https://fpdownload.adobe.com/pub/flashplayer/pdc/24.0.0.186/flash_player_ppapi_linux.x86_64.tar.gz'
  __file__  = __url__.split('/')[-1]
  __tmp__   = '/tmp/pepperflash/'
  __lib__ = 'libpepflashplayer.so'
  try:
    if not os.path.isdir(__tmp__):
      os.mkdir(__tmp__)
    if not os.path.exists(__tmp__ + __file__):
      oe.download_file(__url__, __tmp__ + __file__)
    if not os.path.exists(__tmp__ + __file__):
      oe.notify('Chromium', 'Could not download file')
    else:
      oe.notify('Chromium', 'Extracting libpepflashplayer.so')
    if not os.path.isdir(__tmp__ + __file__):
      oe.execute('tar zxf ' + __tmp__ + __file__ + ' -C ' + __tmp__ + '')
    if not os.path.isdir(__path__ + 'PepperFlash'):
      os.mkdir(__path__ + 'PepperFlash')
    oe.copy_file(__tmp__ + __lib__, __path__ + 'PepperFlash/' + __lib__)
    oe.notify('Chromium', 'Installation of libpepflashplayer.so succeeded')
  except Exception, e:
    oe.notify('Chromium', 'Installation of libpepflashplayer.so failed')

def install_widevine():
  __url__   = 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
  __file__  = __url__.split('/')[-1]
  __tar__   = 'data.tar.xz'
  __tmp__   = '/tmp/widevine/'
  __lib__   = 'opt/google/chrome/libwidevinecdm.so'
  try:
    if not os.path.isdir(__tmp__):
      os.mkdir(__tmp__)
    if not os.path.exists(__tmp__ + __file__):
      oe.download_file(__url__, __tmp__ + __file__)
    if not os.path.exists(__tmp__ + __file__):
      oe.notify('Chromium', 'Could not download file')
    else:
      oe.notify('Chromium', 'Extracting libwidevinecdm.so')
    if not os.path.isdir(__tmp__ + __tar__):
      oe.execute('cd ' + __tmp__ + ' && ar -x ' + __file__)
    oe.execute('tar xf ' + __tmp__ + __tar__ + ' -C ' + __tmp__ + ' ./' + __lib__)
    oe.copy_file(__tmp__ + __lib__, __path__ + __lib__.split('/')[-1])
    oe.notify('Chromium', 'Installation of libwidevinecdm.so succeeded')
  except Exception, e:
    oe.notify('Chromium', 'Installation of libwidevinecdm.so failed')

def pauseXbmc():
  if pauseXBMC == "true":
    xbmc.executebuiltin("PlayerControl(Stop)")
    xbmc.audioSuspend()
    xbmc.enableNavSounds(False)

def resumeXbmc():
  if pauseXBMC == "true":
    xbmc.audioResume()
    xbmc.enableNavSounds(True)

def startChromium(args):
  oe.execute('chmod +x ' + __path__ + 'chromium')
  oe.execute('chmod +x ' + __path__ + 'chromium.bin')
  oe.execute('chmod 4755 ' + __path__ + 'chrome-sandbox')

  try:
    window_mode = {
      'maximized': '--start-maximized',
      'kiosk': '--kiosk',
      'none': '',
    }

    raster_mode = {
      'default': '',
      'off': '--disable-accelerated-2d-canvas --disable-gpu-compositing',
      'force': '--enable-gpu-rasterization --enable-accelerated-2d-canvas --ignore-gpu-blacklist',
    }

    new_env = os.environ.copy()
    vaapi_mode = __addon__.getSetting('VAAPI_MODE')
    gpu_accel_mode = ''
    if vaapi_mode == 'intel':
      new_env['LIBVA_DRIVERS_PATH'] = '/usr/lib/va'
      new_env['LIBVA_DRIVER_NAME'] = 'i965'
    elif vaapi_mode == 'amd':
      new_env['LIBVA_DRIVERS_PATH'] = os.path.join(__addon__.getAddonInfo('path'), 'lib')
      new_env['LIBVA_DRIVER_NAME'] = 'vdpau'
    elif vaapi_mode == 'nvidia':
      new_env['LIBVA_DRIVERS_PATH'] = os.path.join(__addon__.getAddonInfo('path'), 'lib')
      new_env['LIBVA_DRIVER_NAME'] = 'vdpau'
      gpu_accel_mode = '--allow-no-sandbox-job --disable-gpu-sandbox'
    else:
      new_env['LIBGL_ALWAYS_SOFTWARE'] = '1'

    flash_plugin = ''
    if os.path.exists(__path__ + 'PepperFlash/libpepflashplayer.so'):
      flash_plugin = '--ppapi-flash-path=' + __path__ + 'PepperFlash/libpepflashplayer.so'

    if __addon__.getSetting('USE_CUST_AUDIODEVICE') == 'true':
      alsa_device = __addon__.getSetting('CUST_AUDIODEVICE_STR')
    else:
      alsa_device = getAudioDevice()
    alsa_param = ''
    if not alsa_device == None and not alsa_device == '':
      alsa_param = '--alsa-output-device=' + alsa_device

    chrome_params = window_mode.get(__addon__.getSetting('WINDOW_MODE')) + ' ' + \
                    raster_mode.get(__addon__.getSetting('RASTER_MODE')) + ' ' + \
                    flash_plugin + ' ' + \
                    gpu_accel_mode + ' ' + \
                    alsa_param + ' ' + \
                    args + ' ' + \
                    __addon__.getSetting('HOMEPAGE')
    subprocess.call(__path__ + 'chromium ' + chrome_params, shell=True, env=new_env)
  except Exception, e:
    oe.dbg_log('chromium', unicode(e))

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
  if not isRuning('chromium.bin'):
    pauseXbmc()
    startChromium(args)
    while isRuning('chromium.bin'):
      time.sleep(1)
    resumeXbmc()
