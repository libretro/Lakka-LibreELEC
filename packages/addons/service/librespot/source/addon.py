################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
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

import alsaaudio as alsa
import xbmcaddon
import xbmcgui


dialog  = xbmcgui.Dialog()
strings  = xbmcaddon.Addon().getLocalizedString
while True:
   pcms = alsa.pcms()[1:]
   if len(pcms) == 0:
      dialog.ok(xbmcaddon.Addon().getAddonInfo('name'), strings(30210))
      break
   pcmx = dialog.select(strings(30115), pcms)
   if pcmx == -1:
      break
   pcm = pcms[pcmx]
   xbmcaddon.Addon().setSetting('ls_o', pcm)
   break
del dialog


