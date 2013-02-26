"""
################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2013 Stephan Raue (stephan@openelec.tv)
#      Copyright (C) 2013 ultraman/vpeter
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################
"""

import os
import sys
import shutil
import xmlpp
import xbmcaddon

from xml.dom import minidom
from array import array

__settings__      = xbmcaddon.Addon(id='driver.dvb.hdhomerun')
__cwd__           = __settings__.getAddonInfo('path')
__settings_xml__  = xbmc.translatePath(os.path.join(__cwd__, 'resources', 'settings.xml'))

__hdhomerun_log__ = '/var/log/dvbhdhomerun.log'

# make backup settings only once
try:
  with open(__settings_xml__ + '_orig') as f: pass
except IOError as e:
  shutil.copyfile(__settings_xml__, __settings_xml__ + '_orig')

######################################################################################################

# get supported devices on a system (name)
tuners = []
try:
  for line in open(__hdhomerun_log__, 'r'):
    line = line.strip()
    if line.startswith('Registered tuner'):
      name = line.split(':');
      name = name[2].strip()
      tuners.append(name)
except IOError:
  print 'Error reading log file ', __hdhomerun_log__

"""
root ~ # grep "Registered tuner" /var/log/dvbhdhomerun.log
Registered tuner, id from kernel: 0 name: 101ADD2B-0
Registered tuner, id from kernel: 1 name: 101ADD2B-1
Registered tuner, id from kernel: 2 name: 1031D75A-0
Registered tuner, id from kernel: 3 name: 1031D75A-1
"""

######################################################################################################

xmldoc = minidom.parse(__settings_xml__)
category = xmldoc.getElementsByTagName('category')

# remove all nodes with id started with ATTACHED_TUNER_
for node_cat in category:
  setting = node_cat.getElementsByTagName('setting')
  for node_set in setting :
    if 'id' in node_set.attributes.keys() and not node_set.getAttribute('id').find('ATTACHED_TUNER_'):
      node_set.parentNode.removeChild(node_set)

# add new ATTACHED_TUNER_ nodes for available tuners
for node_cat in category:
  setting = node_cat.getElementsByTagName('setting')
  for node_set in setting :
    if 'label' in node_set.attributes.keys() and '9010' in node_set.getAttribute('label'):
      for ix, tuner_name in enumerate(tuners):
        tuner_name_var = tuner_name.replace('-', '_')

        node1 = xmldoc.createElement("setting")
        node1.setAttribute("id", 'ATTACHED_TUNER_' + tuner_name_var + '_DVBMODE')
        node1.setAttribute("label", tuner_name)
        node1.setAttribute("type", 'labelenum')
        node1.setAttribute("default", 'auto')
        node1.setAttribute("values", 'auto|ATSC|DVB-C|DVB-T')
        node_cat.appendChild(node1)

        node2 = xmldoc.createElement("setting")
        node2.setAttribute("id", 'ATTACHED_TUNER_' + tuner_name_var + '_FULLNAME')
        node2.setAttribute("label", '9020')
        node2.setAttribute("type", 'bool')
        node2.setAttribute("default", 'false')
        node_cat.appendChild(node2)

        node3 = xmldoc.createElement("setting")
        node3.setAttribute("id", 'ATTACHED_TUNER_' + tuner_name_var + '_DISABLE')
        node3.setAttribute("label", '9030')
        node3.setAttribute("type", 'bool')
        node3.setAttribute("default", 'false')
        node_cat.appendChild(node3)

      # for tuner
      break

######################################################################################################

# save file back
try:
  outputfile=open(__settings_xml__, 'w')
  xmlpp.pprint(xmldoc.toxml(), output=outputfile, indent=2)
  outputfile.close()
except IOError:
  print 'Error writing file ', __settings_xml__

######################################################################################################

# dialog is closed already so just open settings again
xbmcaddon.Addon(id='driver.dvb.hdhomerun').openSettings()
