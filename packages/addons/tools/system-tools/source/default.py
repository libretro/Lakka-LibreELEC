# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

import xbmcaddon
import xbmcgui
import subprocess
import os.path

if os.path.exists(os.path.join(xbmcaddon.Addon().getAddonInfo('path'), 'bin/st')):
  yes = xbmcgui.Dialog().yesno('System Tools', 'This is a console-only addon.[CR][CR]Open a terminal window?',nolabel='No',yeslabel='Yes')
  if yes:
    subprocess.Popen(["systemd-run","sh","-c",". /etc/profile;cd;exec st -e sh -l"], shell=False, close_fds=True)
else:
  xbmcgui.Dialog().ok('System Tools', 'This is a console-only addon')
