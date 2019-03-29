# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

from PIL import Image

import os
import threading
import time
import Queue
import xbmc
import xbmcaddon

'''
ffwd.png
pause.png
play.png
quit.png
rew.png
shutdown.png
skipf.png
skipr.png
sleep.png
startup.png
stop.png
wake.png
'''

__addon__ = xbmcaddon.Addon()
__path__  = __addon__.getAddonInfo('path')

class PNGPatternPlayer(threading.Thread):

  def __init__(self):
    threading.Thread.__init__(self)
    self.path = __path__ + "/resources/media/ledpatterns"
    self.patterns = Queue.Queue()
    self.responses = Queue.Queue()
    self.stopped = False
    self.memo = {}
    self.start()

  def setPath(self, path):
    if self.path != path:
      self.path = path
      self.memo = {}

  def clearPattern(self):
    with open('/dev/ws2812', 'wb') as f:
      'write null multiple times as the LEDs can get locked up with fast operations'
      for n in range(5):
        f.write(bytearray(25))

  def playPattern(self, file, delay):
    xbmc.log('playing pattern: %s' % file, xbmc.LOGDEBUG)

    'get pixel data from a cache if available, otherwise load and calculate'
    if file not in self.memo:
      image = Image.open(file)
      pixels = image.load()
      width, height = image.size
      data = []

      for y in range(height):
        x_pixels = []
        for x in range(width):
          pixel = []
          r, g, b, a = pixels[x, y]
          pixel.append(hex(r)[2:].zfill(2))
          pixel.append(hex(g)[2:].zfill(2))
          pixel.append(hex(b)[2:].zfill(2))
          pixel.append(hex(a)[2:].zfill(2))
          x_pixels.append(''.join(str(e) for e in pixel))
        data.append(' '.join(str(e) for e in x_pixels))

      self.memo[file] = data

    for hexline in self.memo[file]:
      if not self.stopped:
        with open('/dev/ws2812', 'wb') as f:
          f.write(bytearray.fromhex(hexline))
        time.sleep(delay)
      else:
        break

  def play(self, file, repeat=False, delay=0.030, wait=None):
    self.stopped = True

    if wait is not None:
      # wait up to specified time if this pattern is to be processed synchronously
      self.patterns.put((file, repeat, delay, True))
      try:
        result = self.responses.get(block=True, timeout=wait)
      except Queue.Empty:
        pass
    else:
      self.patterns.put((file, repeat, delay, False))

  def stop(self, wait=None):
    self.play(None, wait=wait)

  def run(self):
    repeat = False

    while True:
      try:
        (file, repeat, delay, wait) = self.patterns.get(block=True, timeout=0 if repeat and not self.stopped else None)

        self.stopped = False

        if file is not None:
          self.playPattern("%s/%s.png" % (self.path, file), delay)
        else:
          self.clearPattern()

        if wait:
          self.responses.put(True)

      # Queue will be empty if we're repeating the last pattern and there is no new work
      except Queue.Empty:
        self.playPattern("%s/%s.png" % (self.path, file), delay)

class SlicePlayer(xbmc.Player):

  def __init__(self, *args, **kwargs):
    xbmc.Player.__init__(self)

    'maps kodi player speed to delay in seconds'
    self.speed_map = {-32: 0.015,
                      -16: 0.025,
                       -8: 0.030,
                       -4: 0.035,
                       -2: 0.040,
                       -1: 0.060,
                        0: 0.000,
                        1: 0.060,
                        2: 0.040,
                        4: 0.035,
                        8: 0.030,
                       16: 0.025,
                       32: 0.015,
                      }

    self.speed = 1
    patterns.play('startup', False, 0.02)
    xbmc.log('service.slice add-on started', xbmc.LOGNOTICE)

  def onPlayBackEnded(self):
    'Will be called when Kodi stops playing a file'

    patterns.play('stop')

  def onPlayBackPaused(self):
    'Will be called when user pauses a playing file'

    patterns.play('pause')

  def onPlayBackResumed(self):
    'Will be called when user resumes a paused file'

    patterns.play('play')

  def onPlayBackSeek(self, iTime, seekOffset): 
    'Will be called when user seeks to a time'

    # todo: not working

    xbmc.log('time offset: %d' % iTime, xbmc.LOGDEBUG)
    xbmc.log('seek offset: %d' % seekOffset, xbmc.LOGDEBUG)

    if seekOffset > 0:
      patterns.play('skipf')
    else:
      patterns.play('skipr')

  def onPlayBackSeekChapter(self, chapter):
    'Will be called when user performs a chapter seek'
    pass

  def onPlayBackSpeedChanged(self, speed):
    'Will be called when players speed changes. (eg. user FF/RW)'

    xbmc.log('seek speed: %d' % speed, xbmc.LOGDEBUG)

    self.speed = speed

    if self.speed != 1:
      if self.speed < 0:
        patterns.play('rew', True, self.speed_map[self.speed])
      elif self.speed > 0:
        patterns.play('ffwd', True, self.speed_map[self.speed])
    else:
      patterns.stop()

  def onPlayBackStarted(self):
    'Will be called when Kodi starts playing a file'

    patterns.play('play')

  def onPlayBackStopped(self):
    'Will be called when user stops Kodi playing a file'

    patterns.play('stop')

class SliceMonitor(xbmc.Monitor):

  def __init__(self, *args, **kwargs):
    xbmc.Monitor.__init__(self)

  def onScreensaverActivated(self):
    'Will be called when screensaver kicks in'

    patterns.play('sleep')

  def onScreensaverDeactivated(self):
    'Will be called when screensaver goes off'

    patterns.play('wake')

  def onSettingsChanged(self):
    'Will be called when addon settings are changed'

    # meh

if (__name__ == "__main__"):
  patterns = PNGPatternPlayer()
  player = SlicePlayer()
  monitor = SliceMonitor()

  monitor.waitForAbort()
  patterns.play('shutdown', wait=5.0)

  del SliceMonitor
  del SlicePlayer
  del PNGPatternPlayer
