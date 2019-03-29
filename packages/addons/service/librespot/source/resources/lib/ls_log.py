# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

import xbmc
import xbmcaddon


_MESSAGE = xbmcaddon.Addon().getAddonInfo('name') + ': {}'


def log(message):
    xbmc.log(_MESSAGE.format(message), xbmc.LOGNOTICE)
