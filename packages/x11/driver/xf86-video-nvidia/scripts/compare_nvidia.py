#!/usr/bin/env python

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv

from __future__ import print_function

import re
import os
import requests
import sys
from lxml import html

category = {
             1: 'Nvidia Geforce GPUs',
             2: 'Nvidia Quadro GPUs',
             3: 'Nvidia NVS GPUs',
             4: 'Nvidia Tesla GPUs',
           }

versions = []
unique_ids = {}
all_ids = {i: [] for i in range(1, len(category))}

def id_in_version(id, ids):
  if any(id == value for value in ids):
    return "x"
  else:
    return " "

if len(sys.argv) <= 1:
  print("Usage: python compare_nvidia.py <version> ...")
  exit()

for version in sys.argv[1:]:
  versions.append(version)

for version in versions:
  url = 'http://us.download.nvidia.com/XFree86/Linux-x86_64/' + version + '/README/supportedchips.html'
  page = requests.get(url)
  tree = html.fromstring(page.content)

  # These are the tables we want to use (gpu's supported by the current driver)
  # NVIDIA GeForce GPUs = 1
  # NVIDIA Quadro GPUs = 2
  # NVIDIA NVS GPUs = 3
  # NVIDIA Tesla GPUs = 4

  ids = {}
  unique_ids[version] = {}

  for table in range(1, len(category)):
    new_ids = tree.xpath('//html/body/div[@class="appendix"]/div[@class="informaltable"][' + str(table) + ']/table/tbody/tr[starts-with(@id, "devid")]/td[2]//text()')
    new_labels = tree.xpath('//html/body/div[@class="appendix"]/div[@class="informaltable"][' + str(table) + ']/table/tbody/tr[starts-with(@id, "devid")]/td[1]//text()')

    # nvidia seems to like to change the way they do things...
    if not new_ids:
      new_ids = tree.xpath('//html/body/div[@class="appendix"]/div[@class="informaltable"][' + str(table) + ']/table/tbody/tr[starts-with(@id, "0x")]/td[2]//text()')
      new_labels = tree.xpath('//html/body/div[@class="appendix"]/div[@class="informaltable"][' + str(table) + ']/table/tbody/tr[starts-with(@id, "0x")]/td[1]//text()')

      # just to make sure we get the raw id without 0x in front
      new_ids = [re.sub(r"^0x", '', id) for id in new_ids]

    # If three IDs are listed, the first is the PCI Device ID, the second is the PCI Subsystem Vendor ID, and the third is the PCI Subsystem Device ID.
    # We only want the PCI Device ID (the first value)
    new_ids = [id.split()[0].lower() for id in new_ids]

    # Sort and remove duplicate ID's
    ids[table] = sorted(set(zip(new_ids, new_labels)))

    # Add ids to list of all ids from all drivers being queried
    all_ids[table].extend(ids[table])

  # Add the ids for the specific driver version
  unique_ids[version] = ids

print("%s\t" % ("ID"), end='')
for version in versions:
  print("%s\t" % (version), end='')
print("Card Name")

print("-----------------------------------------------------------------------------------------------")

for table in all_ids:
  all_ids[table] = sorted(set(all_ids[table]))
  print("%s" % (category[table]))
  print("-----------------------------------------------------------------------------------------------")
  for id in all_ids[table]:
    print("%s\t" % (id[0]), end='')
    for version in versions:
      print("%s\t" % (id_in_version(id, unique_ids[version][table])), end='')
    print("%s\t" % (id[1]), end='')
    print("")
  print("-----------------------------------------------------------------------------------------------\n")
