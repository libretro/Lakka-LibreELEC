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

import os
import subprocess
import xbmc
import xbmcaddon
import xbmcgui


class Monitor(xbmc.Monitor):

   def __init__(self, *args, **kwargs):
      xbmc.Monitor.__init__(self)
      self.setLocale()

   def onSettingsChanged(self):
      self.setLocale()

   def setLocale(self):
      addon = xbmcaddon.Addon()

      charmap = addon.getSetting('charmap')
      locale = addon.getSetting('locale')
      lang = locale + '.' + charmap

      path = addon.getAddonInfo('path')
      i18npath = os.path.join(path, 'i18n')
      locpath = os.path.join(path, 'locpath')
      localepath = os.path.join(locpath, lang)
      profiled = os.path.join(path, 'profile.d')
      profile = os.path.join(profiled, '10-locale.profile')

      strings = addon.getLocalizedString

      if os.path.isdir(locpath) == False:
         os.makedirs(locpath)

      if os.path.isdir(localepath) == False:
         os.environ['I18NPATH'] = i18npath
         subprocess.call(['localedef', '-f', charmap, '-i', locale, localepath])

      if os.path.isdir(profiled) == False:
         os.makedirs(profiled)

      file = open(profile, 'w')
      file.write('export LANG="' + lang + '"\n')
      file.write('export LOCPATH="' + locpath + '"\n')
      file.close()

      current = os.environ.get('LANG', '')
      if lang != current:
         if xbmcgui.Dialog().yesno('Locale', strings(30003).format(lang)
                                  ) == True:
            xbmc.restart()


if __name__ == '__main__':
   Monitor().waitForAbort()
