################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
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

import subprocess
import xbmc
import xbmcaddon


def systemctl(command):
    subprocess.call(
        ['systemctl', command, xbmcaddon.Addon().getAddonInfo('id')])


class Monitor(xbmc.Monitor):

    def __init__(self, *args, **kwargs):
        xbmc.Monitor.__init__(self)
        self.player = Player()

    def onSettingsChanged(self):
        self.player.start('restart')


class Player(xbmc.Player):

    def __init__(self):
        super(Player, self).__init__(self)
        self.start('start')

    def onPlayBackEnded(self):
        if xbmcaddon.Addon().getSetting('sc_k') == 'true':
            xbmc.sleep(500)
            if not self.isPlaying():
                systemctl('start')

    def onPlayBackStarted(self):
        if xbmcaddon.Addon().getSetting('sc_k') == 'true':
            systemctl('stop')

    def onPlayBackStopped(self):
        if xbmcaddon.Addon().getSetting('sc_k') == 'true':
            systemctl('start')

    def start(self, command):
        if xbmcaddon.Addon().getSetting('sc_k') == 'true':
            if self.isPlaying():
                systemctl('stop')
            else:
                systemctl(command)
        else:
            systemctl(command)


if __name__ == '__main__':
    Monitor().waitForAbort()
