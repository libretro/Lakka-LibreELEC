# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

import dbus
import dbus.mainloop.glib
import gobject
import json
import threading
import time
import xbmc
import xbmcaddon

__addon__ = xbmcaddon.Addon()
__addonid__ = __addon__.getAddonInfo('id')

gobject.threads_init()

class KodiFunctions(object):

  def __init__(self):

    self.getjson = {
                      "jsonrpc": "2.0",
                      "method": "Settings.GetSettingValue",
                      "params": {
                                  "setting": "audiooutput.audiodevice",
                                },
                      "id": 1,
                   }

    self.setjson = {
                      "jsonrpc": "2.0",
                      "method": "Settings.SetSettingValue",
                      "params": {
                                  "setting": "audiooutput.audiodevice",
                                  "value": "",
                                },
                      "id": 1,
                   }

    if __addon__.getSetting('audiodevice') == '':
      self.audiodevice = json.loads(xbmc.executeJSONRPC(json.dumps(self.getjson)))['result']['value']
      __addon__.setSetting('audiodevice', self.audiodevice)
    else:
      self.audiodevice = __addon__.getSetting('audiodevice')
    self.pulsedevice = 'PULSE:Default'

    self.select_default()

  def select_default(self):

    self.setjson['params']['value'] = self.audiodevice
    xbmc.executeJSONRPC(json.dumps(self.setjson))

  def select_pulse(self):

    self.setjson['params']['value'] = self.pulsedevice
    xbmc.executeJSONRPC(json.dumps(self.setjson))

class BluetoothAudioClient(object):

  def __init__(self):

    xbmc.log('%s: starting add-on' % __addonid__, xbmc.LOGNOTICE)

    self.devices = {}
    self.signal_added = None
    self.signal_removed = None

    self.kodi = KodiFunctions()

    self._setup_loop()
    self._setup_bus()
    self._setup_signals()

  def quit(self):

    xbmc.log('%s: stopping add-on' % __addonid__, xbmc.LOGNOTICE)

    self.kodi.select_default()

    self.signal_added.remove()
    self.signal_removed.remove()

    self._loop.quit()

  def _setup_loop(self):

    self._loop = gobject.MainLoop()

    self._thread = threading.Thread(target=self._loop.run)
    self._thread.start()

  def _setup_bus(self):

    dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
    self._bus = dbus.SystemBus()

  def _setup_signals(self):

    self.signal_added = self._bus.add_signal_receiver(handler_function=self.switch_audio,
                                                      signal_name='InterfacesAdded',
                                                      dbus_interface='org.freedesktop.DBus.ObjectManager',
                                                      bus_name='org.bluez',
                                                      member_keyword='signal')

    self.signal_removed = self._bus.add_signal_receiver(handler_function=self.switch_audio,
                                                        signal_name='InterfacesRemoved',
                                                        dbus_interface='org.freedesktop.DBus.ObjectManager',
                                                        bus_name='org.bluez',
                                                        member_keyword='signal')

  def switch_audio(self, *args, **kwargs):

    device_path = args[0]

    try:
      if kwargs['signal'] == 'InterfacesAdded':

        self.devices[device_path] = {
                                      'Connected': '',
                                      'Device': '',
                                      'Class': '',
                                    }

        device = self._bus.get_object('org.bluez', device_path)
        device_iface = dbus.Interface(device, dbus.PROPERTIES_IFACE)
        self.devices[device_path]['Device'] = device_iface.Get('org.bluez.MediaTransport1', 'Device')

        audio_device_path = self._bus.get_object('org.bluez', self.devices[device_path]['Device'])
        audio_device_iface = dbus.Interface(audio_device_path, dbus.PROPERTIES_IFACE)
        self.devices[device_path]['Class'] = audio_device_iface.Get('org.bluez.Device1', 'Class')
        self.devices[device_path]['Connected'] = audio_device_iface.Get('org.bluez.Device1', 'Connected')

        if self.devices[device_path]['Class'] & (1 << 21):
          xbmc.log('%s: bluetooth audio device connected' % __addonid__, xbmc.LOGNOTICE)
          xbmc.log('%s: switching to bluetooth audio device' % __addonid__, xbmc.LOGNOTICE)
          self.kodi.select_pulse()

      elif kwargs['signal'] == 'InterfacesRemoved':
        if self.devices[device_path]['Device'] is not None and self.devices[device_path]['Class'] & (1 << 21):
          audio_device_path = self._bus.get_object('org.bluez', self.devices[device_path]['Device'])
          audio_device_iface = dbus.Interface(audio_device_path, dbus.PROPERTIES_IFACE)
          self.devices[device_path]['Connected'] = audio_device_iface.Get('org.bluez.Device1', 'Connected')

          while self.devices[device_path]['Connected']:
            self.devices[device_path]['Connected'] = audio_device_iface.Get('org.bluez.Device1', 'Connected')
            time.sleep(0.1)

          xbmc.log('%s: bluetooth audio device disconnected' % __addonid__, xbmc.LOGNOTICE)
          xbmc.log('%s: checking for other connected devices' % __addonid__, xbmc.LOGNOTICE)

          for path in self.devices:
            if self.devices[path]['Connected'] and self.devices[path]['Class'] & (1 << 21):
              xbmc.log('%s: found connected bluetooth audio device' % __addonid__, xbmc.LOGNOTICE)
              return

          xbmc.log('%s: switching to default audio device' % __addonid__, xbmc.LOGNOTICE)
          self.kodi.select_default()

    except (TypeError, KeyError, dbus.exceptions.DBusException) as e:
      xbmc.log('%s: ' % __addonid__ + unicode(e), xbmc.LOGERROR)

class BluetoothMonitor(xbmc.Monitor):

  def __init__(self, *args, **kwargs):

    xbmc.Monitor.__init__(self)

if (__name__ == "__main__"):
  monitor = BluetoothMonitor()
  client = BluetoothAudioClient()

  monitor.waitForAbort()

  client.quit()

  del BluetoothAudioClient
  del BluetoothMonitor
