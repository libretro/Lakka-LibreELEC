#!/usr/bin/env python

import os
import requests
from lxml import html

__cwd__     = os.path.dirname(os.path.realpath(__file__))
__rules__    = __cwd__ + '/../udev.d/96-nvidia.rules'
__package__ = __cwd__ + '/../package.mk'

# Get the Nvidia driver version currently being used
for line in open(__package__, 'r'):
 if "PKG_VERSION" in line:
   __version__ = line.split('=')[1].replace('"','').strip()
   break

url = 'http://us.download.nvidia.com/XFree86/Linux-x86_64/' + __version__ + '/README/supportedchips.html'
page = requests.get(url)
tree = html.fromstring(page.content)

# These are the tables we want to use (gpu's supported by the current driver)
# NVIDIA GeForce GPUs = 1
# NVIDIA Quadro GPUs = 2
# NVIDIA NVS GPUs = 3
# NVIDIA Tesla GPUs = 4

ids = []
for table in range(1, 5):
  ids = ids + tree.xpath('//html/body/div[@class="appendix"]/div[@class="informaltable"][' + str(table) + ']/table/tbody/tr[starts-with(@id, "devid")]/td[2]//text()')

# If three IDs are listed, the first is the PCI Device ID, the second is the PCI Subsystem Vendor ID, and the third is the PCI Subsystem Device ID.
# We only want the PCI Device ID (the first value)
unique_ids = []
for id in ids:
    unique_ids.append(id.split()[0].lower())

# Sort and remove duplicate ID's
unique_ids = sorted(set(unique_ids))

# Write the rules to the file
with open(__rules__, 'w') as f:
  f.write('ACTION!="add|change", GOTO="end_video"\n')
  f.write('SUBSYSTEM=="pci", ATTR{class}=="0x030000", ATTRS{vendor}=="0x10de", GOTO="subsystem_pci"\n')
  f.write('GOTO="end_video"\n\n')
  f.write('LABEL="subsystem_pci"\n')
  for id in unique_ids:
    f.write('ATTRS{device}=="0x' + str(id) + '", GOTO="configure_nvidia"\n')
  f.write('GOTO="configure_nvidia-legacy"\n\n')
  f.write('LABEL="configure_nvidia"\n')
  f.write('ENV{xorg_driver}="nvidia", TAG+="systemd", ENV{SYSTEMD_WANTS}+="xorg-configure@nvidia.service"\n')
  f.write('GOTO="end_video"\n\n')
  f.write('LABEL="configure_nvidia-legacy"\n')
  f.write('ENV{xorg_driver}="nvidia", TAG+="systemd", ENV{SYSTEMD_WANTS}+="xorg-configure@nvidia-legacy.service"\n')
  f.write('GOTO="end_video"\n\n')
  f.write('LABEL="end_video"\n')
