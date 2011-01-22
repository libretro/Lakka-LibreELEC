
import os
import sys
import xbmcaddon
__scriptname__ = "OpenElecSettings"
__author__ = "stombi"
__url__ = ""
__svn_url__ = ""
__credits__ = ""
__version__ = "0.0.1"
__XBMC_Revision__ = "22240"


__settings__   = xbmcaddon.Addon(id='os.openelec.settings')
__language__   = __settings__.getLocalizedString
__cwd__        = __settings__.getAddonInfo('path')

if __name__ == "__main__":
	__settings__.openSettings()
	
