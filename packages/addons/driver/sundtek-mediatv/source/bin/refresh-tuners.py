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

__settings__      = xbmcaddon.Addon(id='driver.dvb.sundtek-mediatv')
__cwd__           = __settings__.getAddonInfo('path')
__mediaclient__   = xbmc.translatePath(os.path.join(__cwd__, 'bin', 'mediaclient'))
__ld_preload__    = xbmc.translatePath(os.path.join(__cwd__, 'lib', 'libmediaclient.so'))
__settings_xml__  = xbmc.translatePath(os.path.join(__cwd__, 'resources', 'settings.xml'))

__mediaclient_e__ = 'LD_PRELOAD=' + __ld_preload__ + ' ' + __mediaclient__ + ' -e'

# make backup settings only once
try:
  with open(__settings_xml__ + '_orig') as f: pass
except IOError as e:
  shutil.copyfile(__settings_xml__, __settings_xml__ + '_orig')

######################################################################################################

# get supported devices on a system (name, serial number, type)
tuners = []
p = os.popen(__mediaclient_e__, "r")
while 1:
  line = p.readline()
  if not line:
    break
  else:
    str = line.strip()
    if str.startswith('device '):
      name = str[str.find("[")+1:str.find("]")]
      tuners.append([name, 0, 's'])

    if str.startswith('[SERIAL]:'):
      line = p.readline()
      str = line.strip()
      if str.startswith('ID:'):
        id = str.split(':');
        id = id[1].strip()
        tuners[len(tuners)-1] = [name, id, 's']

    if str.startswith('[DVB-C]:'):
      tuners[len(tuners)-1] = [name, id, 'c']
    elif str.startswith('[DVB-T]:'):
      tuners[len(tuners)-1] = [name, id, 'c']
    elif str.startswith('[DVB-T2]:'):
      tuners[len(tuners)-1] = [name, id, 'c']

"""
root ~ # mediaclient -e
**** List of Media Hardware Devices ****
device 0: [Sundtek MediaTV Pro (USB 2.0)]  DVB-C, DVB-T, ANALOG-TV, FM-RADIO, REMOTE-CONTROL, OSS-AUDIO, RDS
  [BUS]:
     ID: 1-7
  [SERIAL]:
     ID: U110714145205
  [DVB-C]:
     FRONTEND: /dev/dvb/adapter0/frontend0
     DVR: /dev/dvb/adapter0/dvr0
     DMX: /dev/dvb/adapter0/demux0
  [DVB-T]:
     FRONTEND: /dev/dvb/adapter0/frontend0
     DVR: /dev/dvb/adapter0/dvr0
     DMX: /dev/dvb/adapter0/demux0
  [ANALOG-TV]:
     VIDEO0: /dev/video0
     VBI0: /dev/vbi0
  [FM-RADIO]:
     RADIO0: /dev/radio0
     RDS: /dev/rds0
  [REMOTECONTROL]:
     INPUT0: /dev/mediainput0
  [OSS]:
     OSS0: /dev/dsp0
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
      for ix, tuner in enumerate(tuners):
        tuner_name   = tuner[0]
        tuner_serial = tuner[1]
        tuner_type   = tuner[2]

        node1 = xmldoc.createElement("setting")
        node1.setAttribute("id", 'ATTACHED_TUNER_' + tuner_serial + '_DVBMODE')
        node1.setAttribute("label", tuner_name + ", " + tuner_serial)
        node1.setAttribute("type", 'labelenum')

        if (tuner_type == 's'):
          node1.setAttribute("default", 'DVB-S')
          node1.setAttribute("values", 'DVB-S')
        else:
          node1.setAttribute("default", 'DVB-C')
          node1.setAttribute("values", 'DVB-C|DVB-T')

        node_cat.appendChild(node1)

        node2 = xmldoc.createElement("setting")
        node2.setAttribute("id", 'ATTACHED_TUNER_' + tuner_serial + '_IRPROT')
        node2.setAttribute("label", '9020')
        node2.setAttribute("type", 'labelenum')
        node2.setAttribute("default", 'auto')
        node2.setAttribute("values", 'auto|RC5|NEC|RC6')
        node_cat.appendChild(node2)

        node3 = xmldoc.createElement("setting")
        node3.setAttribute("id", 'ATTACHED_TUNER_' + tuner_serial + '_KEYMAP')
        node3.setAttribute("label", '9030')
        node3.setAttribute("type", 'text')
        node3.setAttribute("default", 'rc_key_ok')
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
xbmcaddon.Addon(id='driver.dvb.sundtek-mediatv').openSettings()
