################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2018-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

import os
import struct
from fd628utils import *

_led_cmd = '/sys/class/leds/le-vfd/led_cmd'

class fd628Dev:
	def __init__(self):
		import ioctl
		import ctypes
		size = ctypes.sizeof(ctypes.c_int(0))
		self._FD628_IOC_MAGIC = ord('M')
		self._FD628_IOC_SMODE = ioctl.IOW(self._FD628_IOC_MAGIC,  1, size)
		self._FD628_IOC_GMODE = ioctl.IOR(self._FD628_IOC_MAGIC,  2, size)
		self._FD628_IOC_SBRIGHT = ioctl.IOW(self._FD628_IOC_MAGIC,  3, size)
		self._FD628_IOC_GBRIGHT = ioctl.IOR(self._FD628_IOC_MAGIC,  4, size)
		self._FD628_IOC_POWER = ioctl.IOW(self._FD628_IOC_MAGIC,  5, size)
		self._FD628_IOC_GVER = ioctl.IOR(self._FD628_IOC_MAGIC, 6, size)
		self._FD628_IOC_STATUS_LED = ioctl.IOW(self._FD628_IOC_MAGIC, 7, size)
		self._FD628_IOC_GDISPLAY_TYPE = ioctl.IOR(self._FD628_IOC_MAGIC, 8, size)
		self._FD628_IOC_SDISPLAY_TYPE = ioctl.IOW(self._FD628_IOC_MAGIC, 9, size)
		self._FD628_IOC_SCHARS_ORDER = ioctl.IOW(self._FD628_IOC_MAGIC, 10, 7)
		self._FD628_IOC_USE_DTB_CONFIG = ioctl.IOW(self._FD628_IOC_MAGIC, 11, size)
		self._FD628_IOC_MAXNR = 12

	def enableDisplay(self, value):
		self.__writeFD628(self._FD628_IOC_POWER, int(value))

	def getBrightness(self):
		return self.__readFD628(self._FD628_IOC_GBRIGHT)

	def setBrightness(self, value):
		self.__writeFD628(self._FD628_IOC_SBRIGHT, value)

	def getDisplayType(self):
		return self.__readFD628(self._FD628_IOC_GDISPLAY_TYPE)

	def setDisplayType(self, value):
		self.__writeFD628(self._FD628_IOC_SDISPLAY_TYPE, value)

	def setCharacterOrder(self, value):
		pack = struct.pack('BBBBBBB', value[0], value[1], value[2], value[3], value[4], value[5], value[6])
		self.__writeFD628(self._FD628_IOC_SCHARS_ORDER, pack, True)

	def useDtbConfig(self):
		self.__writeFD628(self._FD628_IOC_USE_DTB_CONFIG, 0)

	def __readFD628(self, cmd, isBuf = False):
		import ioctl
		ret = None
		if (ioctl.DIR(cmd) == ioctl.READ and self.__writeFD628(cmd, 0)):
			with open(_led_cmd, "rb") as vfd:
				ret = vfd.read()
			if (ret == ''):
				ret = None
			if (not isBuf and ret != None):
				ret = int(ret, 0)
		kodiLog('fd628Dev.__readFD628: value = {0}'.format(str(ret)))
		return ret

	def __writeFD628(self, cmd, value, isBuf = False):
		ret = False
		if (os.path.isfile(_led_cmd)):
			if isBuf:
				value = ''.join([struct.pack('I', cmd), value])
			else:
				value = struct.pack('Ii', cmd, value)
			kodiLog('fd628Dev.__writeFD628: value = {0}'.format(repr(value)))
			try:
				with open(_led_cmd, "wb") as vfd:
					vfd.write(value)
				ret = True
			except Exception as inst:
				kodiLogError(inst)
		return ret
