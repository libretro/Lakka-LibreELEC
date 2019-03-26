# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

import xbmc
import xbmcaddon

addonName = xbmcaddon.Addon(id='service.fd628').getAddonInfo('name')

def kodiLog(message, level = xbmc.LOGDEBUG):
	xbmc.log('{0} -> {1}'.format(addonName, str(message)), level)

def kodiLogError(message):
	kodiLog(message, xbmc.LOGERROR)

def kodiLogWarning(message):
	kodiLog(message, xbmc.LOGWARNING)

def kodiLogNotice(message):
	kodiLog(message, xbmc.LOGNOTICE)
