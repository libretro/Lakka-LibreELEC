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
