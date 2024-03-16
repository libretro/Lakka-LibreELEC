#!/usr/bin/env python

import os
import subprocess
import sys

retroarch_cfg_file = '/storage/.config/retroarch/retroarch.cfg'
before_audio_device = 'audio_device = "default:CARD=ALSA"'
after_audio_device = 'audio_device = "default:CARD=Headphones"'

if os.path.isfile( retroarch_cfg_file ):
  with open( retroarch_cfg_file ) as f:
    data_lines = f.read()

  data_lines = data_lines.replace( before_audio_device , after_audio_device )

  with open( retroarch_cfg_file, mode="w" ) as f:
    f.write( data_lines )

# Disable (mask) service
#subprocess.run("systemctl disable gpicase-change-audio_device.service", shell=True)
subprocess.run("systemctl mask gpicase-change-audio_device.service", shell=True)

# Delete service link -> It is not able to deleted because '/' is readonly filesystem.
#if(os.path.isfile('/usr/lib/systemd/system/multi-user.target.wants/gpicase-change-audio_device.service')):
#  os.remove('/usr/lib/systemd/system/multi-user.target.wants/gpicase-change-audio_device.service')

sys.exit(0)
