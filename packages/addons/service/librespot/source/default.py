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

import os
import stat
import subprocess
import sys
import threading
import xbmc
import xbmcaddon
import xbmcgui


PORT = '6666'
SINK = 'librespot_sink'


def suspendSink(bit):
   subprocess.call(['pactl', 'suspend-sink', SINK, bit])

def systemctl(command):
   subprocess.call(['systemctl', command, xbmcaddon.Addon().getAddonInfo('id')])


class Controller(threading.Thread):

   FIFO = '/var/run/librespot'

   def __init__(self, player):
      super(Controller, self).__init__()
      self.player = player

   def run(self):
      try:
         os.unlink(self.FIFO)
      except OSError:
         pass
      os.mkfifo(self.FIFO)
      while os.path.exists(self.FIFO) and stat.S_ISFIFO(os.stat(self.FIFO).st_mode):
         with open(self.FIFO, 'r') as fifo:
            command = fifo.read().splitlines()
            if len(command) == 0:
               break
            elif command[0] == 'play' and len(command) == 3:
               dialog = xbmcgui.Dialog()
               dialog.notification(command[1],
                                   command[2],
                                   icon=xbmcaddon.Addon().getAddonInfo('icon'),
                                   sound=False)
               del dialog
               self.player.play()
            elif command[0] == 'stop':
               self.player.stop()
      try:
         os.unlink(self.FIFO)
      except OSError:
         pass

   def stop(self):
      with open(self.FIFO, 'w') as fifo:
         fifo.close()


class Player(xbmc.Player):

   ITEM = 'rtp://127.0.0.1:{port}'.format(port=PORT)

   def __init__(self):
      super(Player, self).__init__(self)
      if self.isPlaying():
         self.onPlayBackStarted()

   def onPlayBackEnded(self):
      suspendSink('1')
      xbmc.sleep(1000)
      if not self.isPlaying():
         systemctl('restart')

   def onPlayBackStarted(self):
      if self.getPlayingFile() != self.ITEM:
         suspendSink('1')
         systemctl('stop')

   def onPlayBackStopped(self):
      systemctl('restart')

   def play(self):
      if not self.isPlaying() and xbmcaddon.Addon().getSetting('ls_O') == 'Kodi':
         suspendSink('0')
         listitem = xbmcgui.ListItem(xbmcaddon.Addon().getAddonInfo('name'))
         listitem.addStreamInfo('audio',{'codec': 'mp3'})
         listitem.setArt({'thumb': xbmcaddon.Addon().getAddonInfo('icon')})
         super(Player, self).play(self.ITEM, listitem)
         del listitem
         xbmcgui.Window(12006).show()

   def stop(self):
      suspendSink('1')
      if self.isPlaying() and self.getPlayingFile() == self.ITEM:
         super(Player, self).stop()
      else:
         systemctl('restart')


class Monitor(xbmc.Monitor):

   def __init__(self, player):
      super(Monitor, self).__init__(self)
      self.player = player

   def onSettingsChanged(self):
      self.player.stop()


if __name__ == '__main__':
   player = Player()
   controller = Controller(player)
   controller.start()
   Monitor(player).waitForAbort()
   controller.stop()
   controller.join()
