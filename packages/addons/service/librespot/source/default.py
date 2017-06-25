################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

import alsaaudio as alsa
import os
import subprocess
import sys
import xbmc
import xbmcaddon
import xbmcgui


ICON     = xbmcaddon.Addon().getAddonInfo('icon')
ID       = xbmcaddon.Addon().getAddonInfo('id')
NAME     = xbmcaddon.Addon().getAddonInfo('name')
PROFILE  = xbmcaddon.Addon().getAddonInfo('profile')
STRINGS  = xbmcaddon.Addon().getLocalizedString

ITEM     = os.path.join(PROFILE, 'librespot.sdp')
LISTITEM = xbmcgui.ListItem(NAME)
LISTITEM.setArt({'thumb': ICON})


def addon():
   if len(sys.argv) == 1:
      Player().play()
   elif sys.argv[1] == 'wizard':
      dialog  = xbmcgui.Dialog()
      while True:
         pcms = alsa.pcms()[1:]
         if len(pcms) == 0:
            dialog.ok(NAME, STRINGS(30210))
            break
         pcmx = dialog.select(STRINGS(30112), pcms)
         if pcmx == -1:
            break
         pcm = pcms[pcmx]
         xbmcaddon.Addon().setSetting('ls_o', pcm)
         break


def systemctl(command):
   subprocess.call(['systemctl', command, ID])


class Monitor(xbmc.Monitor):

   def __init__(self, *args, **kwargs):
      super(Monitor, self).__init__(self)
      self.player = Player()

   def onSettingsChanged(self):
      self.player.stop()


class Player(xbmc.Player):

   def __init__(self, *args, **kwargs):
      super(Player, self).__init__(self)
      if self.isPlaying():
         self.onPlayBackStarted()

   def onPlayBackEnded(self):
      if not self.islibrespot:
         xbmc.sleep(5000)
         if not self.isPlaying():
            systemctl('start')

   def onPlayBackStarted(self):
      if self.getPlayingFile() == ITEM:
         self.islibrespot = True
      else:
         self.islibrespot = False
         systemctl('stop')

   def onPlayBackStopped(self):
      systemctl('restart')

   def play(self):
      if not self.isPlaying():
         super(Player, self).play(ITEM, LISTITEM)

   def stop(self):
      if self.isPlaying():
         if self.getPlayingFile() == ITEM:
            super(Player, self).stop()
      else:
         systemctl('restart')

if __name__ == '__main__':
   Monitor().waitForAbort()
