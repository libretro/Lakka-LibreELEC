################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

import os
import sys
import subprocess
import xbmcaddon

__settings__      = xbmcaddon.Addon(id = 'driver.dvb.sundtek-mediatv')
__cwd__           = __settings__.getAddonInfo('path')
__resources_lib__ = xbmc.translatePath(os.path.join(__cwd__, 'resources', 'lib'))
__settings_xml__  = xbmc.translatePath(os.path.join(__cwd__, 'resources', 'settings.xml'))

__mediaclient__   = xbmc.translatePath(os.path.join(__cwd__, 'bin', 'mediaclient'))
__mediaclient_e__ = __mediaclient__ + ' -e'
__update_sh__     = xbmc.translatePath(os.path.join(__cwd__, 'bin', 'sundtek-update-driver.sh'))

if len(sys.argv) == 2:
  if sys.argv[1] == 'refresh_tuners':
    print "sundtek refresh tuners"
    sys.path.append(__resources_lib__)
    from functions import refresh_sundtek_tuners
    refresh_sundtek_tuners(__settings_xml__, __mediaclient_e__)
    __settings__.openSettings()
  elif sys.argv[1] == 'update_driver':
    print "sundtek update driver"
    proc = subprocess.Popen([__update_sh__], shell = True)
    return_code = proc.wait()
    print "sundtek update driver return value " + str(return_code)
    __settings__.openSettings()
