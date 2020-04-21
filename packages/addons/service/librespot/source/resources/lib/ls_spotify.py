import requests
import time


from ls_addon import ADDON_ICON as ADDON_ICON
from ls_addon import log as log


SPOTIFY_ENDPOINT_EPISODES = 'https://api.spotify.com/v1/episodes/'
SPOTIFY_ENDPOINT_TRACKS = 'https://api.spotify.com/v1/tracks/'
SPOTIFY_HEADERS = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
}
SPOTIFY_REQUEST_TOKEN = {
    'url': 'https://accounts.spotify.com/api/token',
    'data': {'grant_type': 'client_credentials'},
    'headers': {'Authorization': 'Basic MTY5ZGY1NTMyZGVlNDdhNTk5MTNmODUyOGU4M2FlNzE6MWYzZDhiNTA3YmJlNGY2OGJlYjNhNDQ3MmU4YWQ0MTE='}
}


def get(info, indices, default):
    try:
        for index in indices:
            info = info[index]
        return info.encode('utf-8')
    except LookupError:
        return default


class Spotify:

    def __init__(self):
        self.headers = SPOTIFY_HEADERS
        self.expiration = time.time()

    def get_headers(self):
        if time.time() > self.expiration:
            log('token expired')
            token = requests.post(**SPOTIFY_REQUEST_TOKEN).json()
            log(token)
            self.expiration = time.time() + float(token['expires_in']) - 5
            self.headers['Authorization'] = 'Bearer {}'.format(
                token['access_token'])

    def get_endpoint(self, endpoint, id, market):
        try:
            self.get_headers()
            return requests.get(url=endpoint + id,
                                headers=self.headers,
                                params=dict(market=market)).json()
        except Exception as e:
            log('failed to get {} from Spotify {}'.format(endpoint, e))
            return {}

    def update_listitem(self, listitem, type, id, market='SE'):
        if type == 'Podcast':
            info = self.get_endpoint(SPOTIFY_ENDPOINT_EPISODES, id, market)
            album = get(info, ['show', 'name'], 'unknown show',)
            artist = get(info, ['show', 'publisher'], 'unknown publisher')
            thumb = get(info, ['images', 0, 'url'], ADDON_ICON)
            title = get(info, ['name'], 'unknown episode')
        elif type == 'Track':
            info = self.get_endpoint(SPOTIFY_ENDPOINT_TRACKS, id, market)
            album = get(info, ['album', 'name'], 'unknown album')
            artist = get(info, ['artists', 0, 'name'], 'unknown artist')
            thumb = get(info, ['album', 'images', 0, 'url'], ADDON_ICON)
            title = get(info, ['name'], 'unknown title')
        else:
            album = ''
            artist = 'Unknown Media Type'
            thumb = ADDON_ICON
            title = ''
        listitem.setArt(dict(fanart=thumb, thumb=thumb))
        listitem.setInfo('music', dict(
            album=album, artist=artist, title=title))
        log('{}#{}#{}#{}'.format(title, artist, album, thumb))


SPOTIFY = Spotify()
