# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

import base64
import os
import stat
import subprocess
import threading
import time
import requests
import xbmc
import xbmcaddon
import xbmcgui

ADDON = xbmcaddon.Addon()
ADDON_ID = ADDON.getAddonInfo('id')
ADDON_NAME = ADDON.getAddonInfo('name')
FIFO = '/tmp/librespot'
LOG_LEVEL = xbmc.LOGNOTICE
LOG_MESSAGE = ADDON.getAddonInfo('name') + ': {}'
SINK_NAME = "librespot_sink"
STREAM_CODEC = 'pcm_s16be'
STREAM_PORT = '6666'
STREAM_URL = 'rtp://127.0.0.1:{}'.format(STREAM_PORT)


def log(message):
    xbmc.log(LOG_MESSAGE.format(message), LOG_LEVEL)


class Monitor(xbmc.Monitor):

    def __init__(self):
        log('monitor started')
        self.player = Player()

    def onSettingsChanged(self):
        log('settings changed')
        self.player.update()

    def waitForAbort(self):
        super(Monitor, self).waitForAbort()
        log('abort requested')
        self.player.abort()


class Player(threading.Thread, xbmc.Player):

    def __init__(self):
        log('player started')
        super(Player, self).__init__()
        self.isLibrespotStarted = True
        self.listitem = xbmcgui.ListItem()
        self.listitem.addStreamInfo('audio', {'codec': STREAM_CODEC})
        self.listitem.setPath(STREAM_URL)
        self.spotify = Spotify()
        if self.isPlaying():
            self.onAVStarted()
        else:
            self.playingFile = ''
            self.onPlayBackStopped()
        self.start()

    def abort(self):
        log('aborting player')
        with open(FIFO, 'w') as fifo:
            fifo.close()
        self.join()

    def onAVChange(self):
        self.onAVStarted()

    def onAVStarted(self):
        log('playback started')
        self.playingFile = self.getPlayingFile()
        if self.isLibrespotStarted and (self.playingFile != STREAM_URL):
            self.isLibrespotStarted = False
            self.systemctl('stop')

    def onPlayBackEnded(self):
        self.onPlayBackStopped()

    def onPlayBackError(self):
        self.onPlayBackStopped()

    def onPlayBackStopped(self):
        log('playback stopped')
        if self.playingFile == STREAM_URL:
            self.systemctl('restart')
        elif not self.isLibrespotStarted:
            self.systemctl('start')
        self.isLibrespotStarted = True

    def pauseLibrespot(self):
        if self.isPlaying() and (self.getPlayingFile() == STREAM_URL):
            log('pausing librespot playback')
            self.pause()

    def playLibrespot(self, spotify_id):
        type, id = spotify_id.split()
        info = self.spotify.getInfo(type, id)
        self.listitem.setArt(info.getArt())
        self.listitem.setInfo('music', info.getInfo())
        if not self.isPlaying():
            subprocess.call(['pactl', 'suspend-sink', SINK_NAME, '0'])
            log('starting librespot playback')
            self.play(STREAM_URL, self.listitem)
        elif self.getPlayingFile() == STREAM_URL:
            log('updating librespot playback')
            self.updateInfoTag(self.listitem)

    def run(self):
        log('control pipe started')
        try:
            os.unlink(FIFO)
        except OSError:
            pass
        os.mkfifo(FIFO)
        while (os.path.exists(FIFO) and
               stat.S_ISFIFO(os.stat(FIFO).st_mode)):
            with open(FIFO, 'r') as fifo:
                command = fifo.read().splitlines()
                log('control pipe {}'.format(str(command)))
                if len(command) == 0:
                    break
                elif command[0] in ['3', '5', '6']:
                    self.pauseLibrespot()
                elif command[0] in ['1', '2', '4']:
                    self.playLibrespot(command[1])
                elif command[0] in ['7']:
                    self.stopLibrespot()
        try:
            os.unlink(FIFO)
        except OSError:
            pass
        log('control pipe stopped')

    def stopLibrespot(self):
        if self.isPlaying() and (self.getPlayingFile() == STREAM_URL):
            log('stopping librespot playback')
            self.stop()

    def systemctl(self, command):
        log('{} librespot'.format(command))
        subprocess.call(['systemctl', command, ADDON_ID])

    def update(self):
        log('updating player')
        if self.isLibrespotStarted:
            self.systemctl('restart')


class Spotify():

    def __init__(self):
        self.headers = None
        self.expiration = time.time()

    def getHeaders(self):
        if time.time() > self.expiration:
            log('token expired')
            token = requests.post(
                url='https://accounts.spotify.com/api/token',
                data={'grant_type': 'client_credentials'},
                headers={
                    'Authorization': 'Basic MTY5ZGY1NTMyZGVlNDdhNTk5MTNmODUyOGU4M2FlNzE6MWYzZDhiNTA3YmJlNGY2OGJlYjNhNDQ3MmU4YWQ0MTE='}
            ).json()
            print(token)
            log('new token expires in {} seconds'.format(token['expires_in']))
            self.expiration = time.time() + float(token['expires_in']) - 15
            self.headers = {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Authorization': 'Bearer {}'.format(token['access_token'])
            }

    def getEndpoint(self, url):
        try:
            self.getHeaders()
            return requests.get(
                url=url,
                headers=self.headers
            ).json()
        except Exception as e:
            log('failed to get endpoint from Spotify {}'.format(e))
            return {}

    def getInfo(self, type, id):
        if type == 'Track':
            return TrackInfo(self.getEndpoint('https://api.spotify.com/v1/tracks/{}'.format(id)))
        else:
            return UnknownInfo(type, id)


class UnknownInfo:

    def __init__(self, type, id):
        self.id = id
        self.type = type

    def get(self, default, *indices):
        tree = self.info
        try:
            for index in indices:
                tree = tree[index]
        except LookupError:
            tree = default
        return tree

    def getArt(self):
        return {'thumb': ''}

    def getInfo(self):
        return {'album': '', 'artist': self.type, 'title': self.id}


class TrackInfo(UnknownInfo):

    def __init__(self, info):
        self.info = info

    def getArt(self):
        return {
            'thumb': self.get('', 'album', 'images', 0, 'url')
        }

    def getInfo(self):
        return {
            'album':  self.get('', 'album', 'name'),
            'artist': self.get('', 'artists', 0, 'name'),
            'title':  self.get('', 'name')
        }


if __name__ == '__main__':
    log('service started')
    Monitor().waitForAbort()
    log('service stopped')
