# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

import alsaaudio
import xbmcaddon
import xbmcgui


dialog = xbmcgui.Dialog()
strings = xbmcaddon.Addon().getLocalizedString
while True:
    pcms = alsaaudio.pcms()[1:]
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
