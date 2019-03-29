# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

import xbmcaddon

addon = xbmcaddon.Addon(id='service.fd628')

def getSetting(id):
	return addon.getSetting(id)

def getSettingBool(id):
	value = getSetting(id).lower()
	if (value == 'true'):
		value = True
	else:
		value = False
	return value

def getSettingInt(id):
	return int(getSetting(id))

def getSettingNumber(id):
	return float(getSetting(id))

class fd628Settings:
	def __init__(self):
		self.readValues()

	def isDisplayOn(self):
		return self._displayOn

	def isAdvancedSettings(self):
		return self._displayAdvanced

	def getBrightness(self):
		return self._displayBrightness

	def getDisplayType(self):
		return self._displayType

	def isCommonAnode(self):
		return self._commonAnode

	def getDisplay(self):
		value = self.getDisplayType()
		if (self.isCommonAnode()):
			value = value + (1 << 16)
		return value

	def getCharacterIndex(self, i):
		return self._characterIndexes[i]

	def getCharacterIndexes(self):
		return self._characterIndexes

	def isStorageIndicator(self):
		return self._storageIndicator

	def getStorageIndicatorIcon(self):
		return self._storageIndicatorIcon

	def isColonOn(self):
		return self._colonOn

	def readValues(self):
		self._displayAdvanced = False
		self._displayOn = getSettingBool('display.on')
		if (self._displayOn):
			self._displayBrightness = getSettingInt('display.brightness')
			self._storageIndicator = getSettingBool('display.storage.indicator')
			self._storageIndicatorIcon = getSetting('display.storage.indicator.icon')
			self._colonOn = getSettingBool('display.colon.on')
			self._displayAdvanced = getSettingBool('display.advanced')
			if (self._displayAdvanced):
				self._displayType = getSettingInt('display.type')
				self._commonAnode = getSettingBool('display.common.anode')
				self._characterIndexes = []
				for i in range(7):
					self._characterIndexes.append(getSettingInt('display.char.index{0}'.format(i)))
			else:
				self.__initDefaultValues()
		else:
			self.__initDefaultValues()

	def __initDefaultValues(self):
		if not (self._displayOn):
			self._displayBrightness = 7
			self._storageIndicator = False
			self._storageIndicatorIcon = ''
			self._colonOn = False
			self._displayAdvanced = False
		if not (self._displayAdvanced):
			self._displayType = 0
			self._commonAnode = False
			self._characterIndexes = range(0, 7)
