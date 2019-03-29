# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

import xbmc

from ls_log import log as log
from ls_player import Player as Player


class Monitor(xbmc.Monitor):

    def __init__(self):
        log('monitor started')
        self.player = Player()

    def onSettingsChanged(self):
        self.player.onSettingsChanged()

    def waitForAbort(self):
        super(Monitor, self).waitForAbort()
        self.player.onAbortRequested()
        log('monitor stopped')
