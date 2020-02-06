#!/usr/bin/python2
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

from __future__ import print_function
import sys
import dbus
import dbus.mainloop.glib
import gobject
import time

gobject.threads_init()

class BluetoothAudioClient(object):

  def __init__(self):

    self.devices = {}
    self.signal_added = None
    self.signal_removed = None

    self._setup_loop()
    self._setup_bus()
    self._setup_signals()

  def quit(self):

    self.signal_added.remove()
    self.signal_removed.remove()

    self._loop.quit()

  def _setup_loop(self):

    self._loop = gobject.MainLoop()

  def run(self):
    self._loop.run()

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
          print('bluetooth')
          sys.stdout.flush()

      elif kwargs['signal'] == 'InterfacesRemoved':
        if self.devices[device_path]['Device'] is not None and self.devices[device_path]['Class'] & (1 << 21):
          audio_device_path = self._bus.get_object('org.bluez', self.devices[device_path]['Device'])
          audio_device_iface = dbus.Interface(audio_device_path, dbus.PROPERTIES_IFACE)
          self.devices[device_path]['Connected'] = audio_device_iface.Get('org.bluez.Device1', 'Connected')

          while self.devices[device_path]['Connected']:
            self.devices[device_path]['Connected'] = audio_device_iface.Get('org.bluez.Device1', 'Connected')
            time.sleep(0.1)

          for path in self.devices:
            if self.devices[path]['Connected'] and self.devices[path]['Class'] & (1 << 21):
              return

          print('default')
          sys.stdout.flush()

    except (TypeError, KeyError, dbus.exceptions.DBusException) as e:
      print('%s: ' % unicode(e), file=sys.stderr)


client = BluetoothAudioClient()

client.run()

del BluetoothAudioClient
