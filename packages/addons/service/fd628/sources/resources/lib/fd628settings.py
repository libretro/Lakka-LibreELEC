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
