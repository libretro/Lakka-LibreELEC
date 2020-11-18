#!/usr/bin/python3
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

import sys
import time

import asyncio
import ravel

class BluetoothAudioClient(object):

  def __init__(self):

    self.devices = {}
    self.signal_added = None
    self.signal_removed = None

    self._setup_loop()

  def _setup_loop(self):

    self._loop = asyncio.new_event_loop()

    self.bus = ravel.system_bus()
    self.bus.attach_asyncio(self._loop)
    self.bus.listen_objects_added(self.object_added)
    self.bus.listen_objects_removed(self.object_removed)

  def run(self):
    self._loop.run_forever()

  @ravel.signal(name = "InterfacesAdded", in_signature = "oa{sa{sv}}",
                arg_keys = ("device_path", "args"))
  def object_added(self, device_path, args) :
    if 'org.bluez.MediaTransport1' in args:
      self.devices[device_path] = {
        'Connected': '',
        'Device': str(args['org.bluez.MediaTransport1']['Device'][1]),
        'Class': '',
      }

      audio_device_iface = self.bus['org.bluez'][self.devices[device_path]['Device']].get_interface('org.bluez.Device1')
      self.devices[device_path]['Class'] = audio_device_iface.Class
      self.devices[device_path]['Connected'] = audio_device_iface.Connected

      if self.devices[device_path]['Class'] & (1 << 21):
        print('bluetooth')
        sys.stdout.flush()

  @ravel.signal(name = "InterfacesRemoved", in_signature = "oas",
                arg_keys = ("device_path", "args"))
  def object_removed(self, device_path, args) :
    if device_path in self.devices and self.devices[device_path]['Class'] & (1 << 21):
      audio_device_iface = self.bus['org.bluez'][self.devices[device_path]['Device']].get_interface('org.bluez.Device1')
      self.devices[device_path]['Connected'] = audio_device_iface.Connected

      while self.devices[device_path]['Connected']:
        self.devices[device_path]['Connected'] = audio_device_iface.Connected
        time.sleep(0.1)

      for path in self.devices:
        if self.devices[path]['Connected'] and self.devices[path]['Class'] & (1 << 21):
          return

      print('default')
      sys.stdout.flush()


client = BluetoothAudioClient()

client.run()

del BluetoothAudioClient
