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
import os.path
import random
import socket
import struct
import subprocess
import urllib2
import xbmc
import xbmcaddon


ADDON   = xbmcaddon.Addon()
ID      = ADDON.getAddonInfo('id')
PATH    = ADDON.getAddonInfo('path')
TINC    = os.path.join(PATH, 'bin', 'tinc')

def run_code(cmd, *argv):
   return subprocess.call(cmd.format(*argv).split())

def run_lines(cmd, *argv):
   try:
      return subprocess.check_output(cmd.format(*argv).split()).splitlines()
   except subprocess.CalledProcessError:
      return []


class Monitor(xbmc.Monitor):

   def __init__(self, *args, **kwargs):
      xbmc.Monitor.__init__(self)

   def onSettingsChanged(self):
     run_code('systemctl restart {}'.format(ID))


if __name__ == '__main__':
   for network in run_lines('{} network', TINC):
      run_code('{} -n {} start', TINC, network)

   if ADDON.getSetting('tinc_wizard') == 'true':
      try:
         ip = urllib2.urlopen('http://ip.42.pl/raw').read()
         address = socket.gethostbyaddr(ip)[0]
         ADDON.setSetting('tinc_address', address)
      except:
         pass

      network, mask = '10.0.0.0/8'.split('/')
      mask = 2 ** (32 - int(mask)) - 1
      network = struct.unpack('!L', socket.inet_aton(network))[0] & -mask
      ip = network + random.randint(1, mask - 1)
      name = format(ip, '08x')
      subnet = socket.inet_ntoa(struct.pack('!L', ip))
      ADDON.setSetting('tinc_name', name)
      ADDON.setSetting('tinc_subnet', subnet)

      port = int(ADDON.getSetting('tinc_port'))
      s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
      try:
         s.bind(('', port))
         s.close()
      except socket.error:
         s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
         s.bind(('', 0))
         a, port = s.getsockname()
         s.close()
         ADDON.setSetting('tinc_port', str(port))

      ADDON.setSetting('tinc_wizard', 'false')
      run_code('systemctl restart {}'.format(ID))

   Monitor().waitForAbort()
