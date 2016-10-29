################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
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
import xbmcgui
import xbmcaddon

__scriptid__ = 'service.touchscreen'
__addon__    = xbmcaddon.Addon(id=__scriptid__)
_            = __addon__.getLocalizedString

# http://forum.kodi.tv/showthread.php?tid=230766
def handle_wait(time_to_wait, title, text):
    dialog = xbmcgui.DialogProgress()
    ret = dialog.create(' ' + title)
    secs = 0
    percent = 0
    increment = int(100 / time_to_wait)

    while secs < time_to_wait:
        secs += 1
        percent = increment*secs
        secs_left = time_to_wait - secs
        remaining_display = (_(2030).encode('utf-8')) % secs_left
        dialog.update(percent, text, "", remaining_display)
        xbmc.sleep(1000)

    dialog.close()
    return False

# how long to lock the screen
lock_secs = 30
handle_wait(lock_secs, _(2010).encode('utf-8'), _(2020).encode('utf-8'))
