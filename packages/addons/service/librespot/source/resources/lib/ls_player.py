# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

import os
import stat
import threading
import xbmc
import xbmcaddon
import xbmcgui

from ls_librespot import Librespot as Librespot
from ls_log import log as log
from ls_spotify import Spotify as Spotify

_CODEC = 'pcm_s16le'
_FIFO = '/var/run/librespot'
_STREAM = 'rtp://127.0.0.1:6666'

_DEFAULT_ICON = xbmcaddon.Addon().getAddonInfo('icon')
_DEFAULT_TITLE = xbmcaddon.Addon().getAddonInfo('name')


class Player(threading.Thread, xbmc.Player):

    def __init__(self):
        super(Player, self).__init__()
        self.updateSettings()
        self.dialog = xbmcgui.Dialog()
        self.librespot = Librespot()
        self.listitem = xbmcgui.ListItem()
        self.listitem.addStreamInfo('audio', {'codec': _CODEC})
        self.listitem.setPath(_STREAM)
        self.spotify = Spotify()
        self.start()
        if self.isPlaying():
            self.onPlayBackStarted()

    def onAbortRequested(self):
        log('abort requested')
        with open(_FIFO, 'w') as fifo:
            fifo.close()
        self.join()

    def onPlayBackEnded(self):
        log('a playback ended')
        self.librespot.restart()

    def onPlayBackStarted(self):
        log('a playback started')
        if self.getPlayingFile() != _STREAM:
            self.librespot.stop()

    def onPlayBackStopped(self):
        log('a playback stopped')
        self.librespot.restart()

    def onSettingsChanged(self):
        log('settings changed')
        self.stop()
        self.updateSettings()

    def pause(self):
        if self.isPlaying() and self.getPlayingFile() == _STREAM:
            log('pausing librespot playback')
            super(Player, self).pause()

    def play(self, track_id):
        track = self.spotify.getTrack(track_id)
        if track['thumb'] == '':
            track['thumb'] = _DEFAULT_ICON
        if track['title'] == '':
            track['title'] = _DEFAULT_TITLE
        if self.kodi:
            self.listitem.setArt({'thumb': track['thumb']})
            self.listitem.setInfo(
                'music',
                {
                    'album': track['album'],
                    'artist': track['artist'],
                    'title': track['title']
                }
            )
            if self.isPlaying() and self.getPlayingFile() == _STREAM:
                log('updating librespot playback')
                self.updateInfoTag(self.listitem)
            else:
                self.librespot.unsuspend()
                log('starting librespot playback')
                super(Player, self).play(_STREAM, self.listitem)
        else:
            self.dialog.notification(
                track['title'],
                track['artist'],
                icon=track['thumb'],
                sound=False)

    def run(self):
        log('named pipe started')
        try:
            os.unlink(_FIFO)
        except OSError:
            pass
        os.mkfifo(_FIFO)
        while (os.path.exists(_FIFO) and
               stat.S_ISFIFO(os.stat(_FIFO).st_mode)):
            with open(_FIFO, 'r') as fifo:
                command = fifo.read().splitlines()
                log('named pipe received {}'.format(str(command)))
                if len(command) == 0:
                    break
                elif command[0] == 'play':
                    self.play(command[1])
                elif command[0] == 'stop':
                    self.stop()
                elif command[0] == 'pause':
                    self.pause()
        try:
            os.unlink(_FIFO)
        except OSError:
            pass
        log('named pipe stopped')

    def stop(self):
        if self.isPlaying():
            if self.getPlayingFile() == _STREAM:
                log('stopping librespot playback')
                super(Player, self).stop()
            else:
                self.librespot.stop()
        else:
            self.librespot.restart()

    def updateSettings(self):
        self.kodi = (xbmcaddon.Addon().getSetting('ls_m') == 'Kodi')
