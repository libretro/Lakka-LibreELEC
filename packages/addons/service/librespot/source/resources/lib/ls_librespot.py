# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

import subprocess
import xbmcaddon

from ls_log import log as log


_SERVICE = xbmcaddon.Addon().getAddonInfo('id')
_SINK = 'librespot_sink'


def _pactl(bit):
    log('pactl {}'.format(bit))
    subprocess.call(['pactl', 'suspend-sink', _SINK, bit])


def _systemctl(command):
    log('systemctl {}'.format(command))
    subprocess.call(['systemctl', command, _SERVICE])
    _pactl('1')


class Librespot():

    def __init__(self):
        self.state = True

    def restart(self):
        log('restarting librespot')
        _systemctl('restart')
        self.state = True

    def stop(self):
        if self.state:
            log('stopping librespot')
            _systemctl('stop')
            self.state = False

    def unsuspend(self):
        _pactl('0')
