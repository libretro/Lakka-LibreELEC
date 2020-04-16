import pipes
import shlex
import subprocess
import threading
import xbmc
import xbmcgui

from ls_addon import ADDON_ENVT as ADDON_ENVT
from ls_addon import ADDON_HOME as ADDON_HOME
from ls_addon import get_settings as get_settings
from ls_addon import log as log
from ls_pulseaudio import Pulseaudio as Pulseaudio
from ls_spotify import SPOTIFY as SPOTIFY


LIBRESPOT = 'librespot' \
            ' --backend pulseaudio' \
            ' --bitrate {bitrate}' \
            ' --cache cache' \
            ' --device {device}' \
            ' --device-type TV' \
            ' --disable-audio-cache' \
            ' --name {name}' \
            ' --notify-kodi'
LIBRESPOT_AUTOPLAY = ' --autoplay'
LIBRESPOT_AUTHENTICATE = ' --disable-discovery' \
                         ' --password {password}' \
                         ' --username {username}'

CODEC = 'pcm_s16be'
MAX_PANICS = 3


class Librespot(xbmc.Player):

    def __init__(self):
        super(Librespot, self).__init__()
        settings = get_settings()
        quoted = {k: pipes.quote(v) for (k, v) in settings.items()}
        command = LIBRESPOT
        if settings['autoplay'] == 'true':
            command += LIBRESPOT_AUTOPLAY
        if (settings['discovery'] == 'false' and
                settings['password'] != '' and
                settings['username'] != ''):
            command += LIBRESPOT_AUTHENTICATE
        self.command = shlex.split(command.format(**quoted))
        log(shlex.split(command.format(**dict(quoted, password='*obfuscated*'))))
        self.is_aborted = False
        self.is_dead = False
        self.pulseaudio = Pulseaudio(settings)
        self.listitem = xbmcgui.ListItem()
        self.listitem.addStreamInfo('audio', {'codec': CODEC})
        self.listitem.setPath(path=self.pulseaudio.url)

    def __enter__(self):
        self.pulseaudio.load_modules()
        self.panics = 0
        self.librespot = None
        self.is_playing_librespot = False
        if not self.isPlaying():
            self.start_librespot()

    def __exit__(self, *args):
        self.stop_librespot()
        self.pulseaudio.unload_modules()

    def on_event_panic(self):
        self.pulseaudio.suspend_sink(1)
        self.panics += 1
        log('event panic {}/{}'.format(self.panics, MAX_PANICS))
        self.is_dead = self.panics >= MAX_PANICS
        self.stop_librespot(True)

    def on_event_playing(self, type, id):
        log('event playing')
        SPOTIFY.update_listitem(self.listitem, type, id, self.country)
        if not self.isPlaying():
            log('starting librespot playback')
            self.pulseaudio.suspend_sink(0)
            self.play(self.pulseaudio.url, self.listitem)
        elif self.is_playing_librespot:
            log('updating librespot playback')
            self.updateInfoTag(self.listitem)

    def on_event_stopped(self):
        self.pulseaudio.suspend_sink(1)
        log('event stopped')
        self.panics = 0
        self.stop()

    def onPlayBackEnded(self):
        self.onPlayBackStopped()

    def onPlayBackError(self):
        self.onPlayBackStopped()

    def onPlayBackStarted(self):
        log('Kodi playback started')
        self.is_playing_librespot = self.getPlayingFile() == self.pulseaudio.url
        if not self.is_playing_librespot:
            self.stop_librespot()

    def onPlayBackStopped(self):
        if self.is_playing_librespot:
            log('librespot playback stopped')
            self.is_playing_librespot = False
            self.stop_librespot(True)
        else:
            log('Kodi playback stopped')
            self.start_librespot()

    def run_librespot(self):
        log('librespot thread started')
        self.restart = True
        while self.restart and not self.is_dead:
            self.librespot = subprocess.Popen(
                self.command,
                cwd=ADDON_HOME,
                env=ADDON_ENVT,
                stderr=subprocess.STDOUT,
                stdout=subprocess.PIPE)
            log('librespot started')
            with self.librespot.stdout:
                while True:
                    line = self.librespot.stdout.readline()
                    if line == '':
                        break
                    words = line.split()
                    if words[0] == '@Playing':
                        self.on_event_playing(words[1], words[2])
                    elif words[0] == '@Stopped':
                        self.on_event_stopped()
                    elif words[0] == 'stack':
                        self.on_event_panic()
                    else:
                        log(line.rstrip())
                        if 'Country:' in line:
                            self.country = words[-1].strip('"')
                            log('country={}'.format(self.country))
            self.pulseaudio.suspend_sink(1)
            self.stop()
            self.librespot.wait()
            log('librespot stopped')
        self.librespot = None
        log('librespot thread stopped')

    def start_librespot(self):
        if self.librespot is None:
            self.thread = threading.Thread(target=self.run_librespot)
            self.thread.start()

    def stop(self):
        if self.is_playing_librespot and not self.is_aborted:
            log('stopping librespot playback')
            self.is_playing_librespot = False
            super(Librespot, self).stop()

    def stop_librespot(self, restart=False):
        self.restart = restart
        if self.librespot is not None:
            self.librespot.terminate()
            if not restart:
                self.thread.join()
