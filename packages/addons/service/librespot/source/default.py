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

PORT = '6666'
SINK = 'librespot_sink'

NAME     = xbmcaddon.Addon().getAddonInfo('name')
STRINGS  = xbmcaddon.Addon().getLocalizedString


def addon():
   if len(sys.argv) == 1:
      pass
   elif sys.argv[1] == 'start':
      Player().play()
   elif sys.argv[1] == 'stop':
      Player().stop()
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


class Monitor(xbmc.Monitor):

   def __init__(self, *args, **kwargs):
      super(Monitor, self).__init__(self)
      self.player = Player()

   def onSettingsChanged(self):
      self.player.stop()


class Player(xbmc.Player):

   ITEM = 'rtp://127.0.0.1:{port}'.format(port=PORT)
   LISTITEM = xbmcgui.ListItem(NAME)
   LISTITEM.setArt({'thumb': xbmcaddon.Addon().getAddonInfo('icon')})

   def __init__(self, *args, **kwargs):
      super(Player, self).__init__(self)
      self.service = Service()
      self.sink = Sink()
      if self.isPlaying():
         self.onPlayBackStarted()

   def onPlayBackEnded(self):
      xbmc.sleep(1000)
      if not self.isPlaying():
         self.service.restart()

   def onPlayBackStarted(self):
      if self.getPlayingFile() != self.ITEM:
         self.sink.suspend()
         self.service.stop()

   def onPlayBackStopped(self):
      self.service.restart()

   def play(self):
      if not self.isPlaying():
         self.sink.unsuspend()
         super(Player, self).play(self.ITEM, self.LISTITEM)

   def stop(self):
      self.sink.suspend()
      if self.isPlaying() and self.getPlayingFile() == self.ITEM:
         super(Player, self).stop()
      else:
         self.service.restart()


class Service():

   def __init__(self):
      self.id = xbmcaddon.Addon().getAddonInfo('id')

   def restart(self):
      self.systemctl('restart')

   def start(self):
      self.systemctl('start')

   def stop(self):
      self.systemctl('stop')

   def systemctl(self, command):
      subprocess.call(['systemctl', command, self.id])


class Sink():

   def suspend(self):
      subprocess.call(['pactl', 'suspend-sink', SINK, '1'])

   def unsuspend(self):
      subprocess.call(['pactl', 'suspend-sink', SINK, '0'])


if __name__ == '__main__':
   Monitor().waitForAbort()
