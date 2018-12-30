# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

import xbmcgui
import subprocess

yes = xbmcgui.Dialog().yesno('', 'This is a console-only addon','','Open a terminal window?','No','Yes')
if yes:
  subprocess.Popen(["systemd-run","sh","-c",". /etc/profile;cd;exec mrxvt -ls"], shell=False, close_fds=True)

