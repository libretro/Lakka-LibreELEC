# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

import base64
import json
import os
import stat
import subprocess
import threading
import time
import urllib
import urllib2
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
SPOTIFY_ID = '169df5532dee47a59913f8528e83ae71'
SPOTIFY_SECRET = '1f3d8b507bbe4f68beb3a4472e8ad411'
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

    def playLibrespot(self, track_id):
        track = self.spotify.getTrack(track_id)
        self.listitem.setArt(track.getArt())
        self.listitem.setInfo('music', track.getInfo())
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
        self.request = [
            'https://accounts.spotify.com/api/token',
            urllib.urlencode({'grant_type': 'client_credentials'}),
            {'Authorization': 'Basic {}'.format(base64.b64encode(
                '{}:{}'.format(SPOTIFY_ID, SPOTIFY_SECRET)))}
        ]

    def getHeaders(self):
        if time.time() > self.expiration:
            log('token expired')
            token = json.loads(urllib2.urlopen(
                urllib2.Request(*self.request)).read())
            log('new token expires in {} seconds'.format(token['expires_in']))
            self.expiration = time.time() + float(token['expires_in']) - 60
            self.headers = {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Authorization': 'Bearer {}'.format(token['access_token'])
            }

    def getTrack(self, track_id):
        log('getting track')
        try:
            self.getHeaders()
            track = json.loads(urllib2.urlopen(urllib2.Request(
                'https://api.spotify.com/v1/tracks/{}'.format(track_id), None,
                self.headers)).read())
        except Exception as e:
            log('failed to get track from Spotify: {}'.format(e))
            track = dict()
        return Track(track)


class Track():

    def __init__(self, track):
        self.track = track

    def get(self, default, *indices):
        tree = self.track
        try:
            for index in indices:
                tree = tree[index]
        except LookupError:
            tree = default
        return tree

    def getArt(self):
        return {
            'thumb': self.get('', 'album', 'images', 0, 'url')
        }

    def getInfo(self):
        return {
            'album':  self.get('', 'album', 'name'),
            'artist': self.get('', 'artists', 0, 'name'),
            'title':  self.get('', 'name'),
        }


if __name__ == '__main__':
    log('service started')
    Monitor().waitForAbort()
    log('service stopped')
