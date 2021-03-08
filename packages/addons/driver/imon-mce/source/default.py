# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2021-present Team LibreELEC (https://libreelec.tv)

import os
import sys
import xbmcaddon
import xbmcvfs

__scriptname__ = "IMON MCE Remote driver"
__author__ = "LibreELEC"
__url__ = "https://libreelec.tv"
__settings__   = xbmcaddon.Addon(id='driver.remote.imon-mce')
__cwd__        = __settings__.getAddonInfo('path')
__path__       = xbmcvfs.translatePath( os.path.join( __cwd__, 'bin', "imon-mce.service") )

os.system(__path__)
