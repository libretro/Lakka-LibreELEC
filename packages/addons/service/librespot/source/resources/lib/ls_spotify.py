# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

import base64
import json
import time
import urllib
import urllib2

from ls_log import log as log

_CLIENT_ID = '169df5532dee47a59913f8528e83ae71'
_CLIENT_SECRET = '1f3d8b507bbe4f68beb3a4472e8ad411'


def _get(default, tree, *indices):
    try:
        for index in indices:
            tree = tree[index]
    except LookupError:
        tree = default
    return tree


class Spotify():

    def __init__(self):
        self.headers = None
        self.expiration = time.time()
        self.request = [
            'https://accounts.spotify.com/api/token',
            urllib.urlencode({'grant_type': 'client_credentials'}),
            {'Authorization': 'Basic {}'.format(base64.b64encode(
                '{}:{}'.format(_CLIENT_ID, _CLIENT_SECRET)))}
        ]

    def getTrack(self, track_id):
        try:
            if time.time() > self.expiration:
                log('token expired')
                token = json.loads(urllib2.urlopen(
                    urllib2.Request(*self.request)).read())
                log('token {} expires in {} seconds'.format(
                    token['access_token'], token['expires_in']))
                self.expiration = time.time() + float(token['expires_in']) - 60
                self.headers = {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer {}'.format(token['access_token'])
                }
            track = json.loads(urllib2.urlopen(urllib2.Request(
                'https://api.spotify.com/v1/tracks/{}'.format(track_id), None,
                self.headers)).read())
        except Exception as e:
            log('failed to get track {} from Spotify: {}'.format(e))
            track = dict()
        return {
            'album': _get('', track, 'album', 'name'),
            'artist': _get('', track, 'artists', 0, 'name'),
            'duration': _get(0, track, 'duration_ms') / 1000,
            'thumb': _get('', track, 'album', 'images', 0, 'url'),
            'title': _get('', track, 'name')
        }
