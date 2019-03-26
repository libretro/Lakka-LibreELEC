# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

import xbmc
import os
from fd628utils import *

class fd628State(object):
	def __init__(self, ledName):
		self._value = False
		self._hasChanged = False
		self._ledName = ledName

	def _getStr(self, className):
		return '{0} ({1})'.format(className, self._ledName)

	def update(self):
		raise NotImplementedError

	def getValue(self):
		return self._value

	def hasChanged(self):
		return self._hasChanged

	def getLedName(self):
		return self._ledName

	def _update(self, value):
		if (value != self._value):
			self._hasChanged = True
			self._value = value
		else:
			self._hasChanged = False

class fd628IconIndicator(fd628State):
	def __init__(self, on, ledName):
		super(fd628IconIndicator, self).__init__(ledName)
		self._on = on

	def __str__(self):
		return self._getStr('fd628IconIndicator')

	def turnOn(self):
		self._on = True

	def turnOff(self):
		self._on = False

	def toggle(self):
		self._on = not self._on

	def update(self):
		self._update(self._on)

class fd628CondVisibility(fd628State):
	def __init__(self, ledName, cmd):
		super(fd628CondVisibility, self).__init__(ledName)
		self._cmd = cmd

	def __str__(self):
		return self._getStr('fd628CondVisibility')

	def update(self):
		value = xbmc.getCondVisibility(self._cmd)
		self._update(value)

class fd628FileContains(fd628State):
	def __init__(self, ledName, path, strings):
		super(fd628FileContains, self).__init__(ledName)
		self._path = path
		self._strings = strings

	def __str__(self):
		return self._getStr('fd628FileContains')

	def update(self):
		if (os.path.isfile(self._path)):
			with open(self._path, 'rb') as state:
				content = state.read()
			value = self.__checkContent(content)
			self._update(value)
		else:
			self._update(False)

	def __checkContent(self, content):
		ret = False
		for s in self._strings:
			if (s in content):
				ret = True
				break
		return ret

class fd628WindowChecker(fd628State):
	def __init__(self, ledName, windows):
		super(fd628WindowChecker, self).__init__(ledName)
		self._windows = windows

	def __str__(self):
		return self._getStr('fd628WindowChecker')

	def update(self):
		value = False
		for id in self._windows:
			if (xbmc.getCondVisibility('Window.IsVisible({0})'.format(id))):
				value = True
				break
		self._update(value)

class fd628ExtStorageChecker(fd628State):
	def __init__(self, ledName, path):
		super(fd628ExtStorageChecker, self).__init__(ledName)
		self._path = path

	def __str__(self):
		return self._getStr('fd628ExtStorageChecker')

	def update(self):
		value = False
		for folder, subs, files in os.walk('/dev/disk/by-uuid'):
			for filename in files:
				path = os.path.realpath(os.path.join(folder, filename))
				if (path.startswith(self._path)):
					value = True
					break
		self._update(value)

class fd628ExtStorageCount(fd628State):
	def __init__(self, ledName, drives, type):
		super(fd628ExtStorageCount, self).__init__(ledName)
		if (drives == None):	# Monitor all drives
			self._drives = None
			drives = self.__getAllDrives()
		else:			# Monitor listed drives
			self._drives = drives
			drives = self.__getSelectedDrives()
		self._driveStats = {key: self.__readStatus(key) for key in drives}
		kodiLogNotice('fd628ExtStorageCount.__init__: Drive stats ' + str(self._driveStats))
		self._read = False
		self._write = False
		if (type == 'r'):
			self._read = True
		elif (type == 'w'):
			self._write = True
		elif (type == 'rw'):
			self._read = True
			self._write = True
		else:
			raise Exception('\'type\' must be \'r\', \'w\' or \'rw\'.')

	def update(self):
		value = False
		if (self._drives == None):
			drives = self.__getAllDrives()
		else:
			drives = self.__getSelectedDrives()
		for drive in drives:
			if (not drive in self._driveStats):
				self._driveStats[drive] = None
				kodiLogNotice('fd628ExtStorageCount.update: New drive found \'{0}\''.format(drive))
		for path, stats in self._driveStats.iteritems():
			newStats = self.__readStatus(path)
			if (stats != None and newStats != None):
				if (self._read):
					value = value or stats[0] != newStats[0]
				if (self._write):
					value = value or stats[1] != newStats[1]
			self._driveStats[path] = newStats
		self._update(value)

	def __readStatus(self, path):
		path = os.path.join('/sys/block', path, 'stat')
		if (os.path.isfile(path)):
			with open(path, 'rb') as status:
				values = status.read().split()
			return (values[2], values[6])
		else:
			return None

	def __getAllDrives(self):
		drives = []
		for folder, subs, files in os.walk('/sys/block'):
			drives = [sub for sub in subs if (not sub.startswith('loop'))]
		return drives

	def __getSelectedDrives(self):
		return [drive for drive in self.__getAllDrives() if ([d for d in self._drives if drive.startswith(d)])]
