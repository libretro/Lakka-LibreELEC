################################################################################                                    
#      This file is part of OpenELEC - http://www.openelec.tv                                                       
#      Copyright (C) 2012 Lukas Heiniger
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


# Initializes and launches SABnzbd, Couchpotato, Sickbeard and Headphones

import os
import shutil
import xbmc
import signal
import subprocess
import urllib2
from configobj import ConfigObj
from xml.dom.minidom import parseString
import logging

logging.basicConfig(filename='/var/log/sabnzbd-suite.log',
                    filemode='w',
                    format='%(asctime)s SABnzbd-Suite: %(message)s', 
                    level=logging.WARNING)




# helper functions
# ----------------

def createDir(dir):
    if not os.path.isdir(dir):
        os.makedirs(dir)
        
def getAddonSetting(doc,id):
    for element in doc.getElementsByTagName('setting'):
        if element.getAttribute('id')==id:
            return element.getAttribute('value')
            
def loadWebInterface(url,user,pwd):
    passman = urllib2.HTTPPasswordMgrWithDefaultRealm()
    passman.add_password(None, url, user, pwd)
    authhandler = urllib2.HTTPBasicAuthHandler(passman)
    opener = urllib2.build_opener(authhandler)
    urllib2.install_opener(opener)
    pagehandle = urllib2.urlopen(url)
    return pagehandle.read()
    



# define some things that we're gonna need, mainly paths
# ------------------------------------------------------

# addon
pAddon                = os.path.expanduser('~/.xbmc/addons/service.downloadmanager.SABnzbd-Suite')
pAddonHome            = os.path.expanduser('~/.xbmc/userdata/addon_data/service.downloadmanager.SABnzbd-Suite')

# settings
pDefaultSuiteSettings = os.path.join(pAddon, 'settings-default.xml')
pSuiteSettings        = os.path.join(pAddonHome, 'settings.xml')
pXbmcSettings         = '/storage/.xbmc/userdata/guisettings.xml'
pSabNzbdSettings      = os.path.join(pAddonHome, 'sabnzbd.ini')
pSickBeardSettings    = os.path.join(pAddonHome, 'config.ini')
pCouchPotatoSettings  = os.path.join(pAddonHome, 'couchpotato.ini')
pHeadphonesSettings   = os.path.join(pAddonHome, 'headphones.ini')

# directories
pSabNzbdComplete      = '/storage/downloads'
pSabNzbdCompleteMov   = '/storage/downloads/movies'
pSabNzbdCompleteMusic = '/storage/downloads/music'
pSabNzbdIncomplete    = '/storage/downloads/incomplete'
pSickBeardTvScripts   = os.path.join(pAddon, 'SickBeard/autoProcessTV')
pSabNzbdScripts       = os.path.join(pAddonHome, 'scripts')


# pylib
pPylib                = os.path.join(pAddon, 'pylib')

# service commands
sabnzbd               = ['python', os.path.join(pAddon, 'SABnzbd/SABnzbd.py'), 
                         '-d', '-f',  pSabNzbdSettings, '-l 0']
sickBeard             = ['python', os.path.join(pAddon, 'SickBeard/SickBeard.py'), 
                         '--daemon', '--datadir', pAddonHome]
couchPotato           = ['python', os.path.join(pAddon, 'CouchPotato/CouchPotato.py'), 
                         '-d', '--datadir', pAddonHome, '--config', pCouchPotatoSettings]
headphones            = ['python', os.path.join(pAddon, 'Headphones/Headphones.py'), 
                         '-d', '--datadir', pAddonHome, '--config', pHeadphonesSettings]

# Other stuff
sabNzbdHost           = '127.0.0.1:8081'
addonId               = 'service.downloadmanager.SABnzbd-Suite'




# create directories and settings on first launch
# -----------------------------------------------

firstLaunch = not os.path.exists(pSabNzbdSettings)
if firstLaunch:
    logging.debug('First launch, creating directories')
    createDir(pAddonHome)
    createDir(pSabNzbdComplete)
    createDir(pSabNzbdCompleteMov)
    createDir(pSabNzbdCompleteMusic)
    createDir(pSabNzbdIncomplete)
    createDir(pSabNzbdScripts)
    shutil.copy(os.path.join(pSickBeardTvScripts,'sabToSickBeard.py'), pSabNzbdScripts)
    shutil.copy(os.path.join(pSickBeardTvScripts,'autoProcessTV.py'), pSabNzbdScripts)
    os.chmod(os.path.join(pSabNzbdScripts,'sabToSickBeard.py'), 0755)
    # the settings file already exists if the user set settings before the first launch
    if not os.path.exists(pSuiteSettings):
        shutil.copy(pDefaultSuiteSettings, pSuiteSettings)
    # make utilities executable
    for utility in {'par2','unrar','unzip'}:
        os.chmod(os.path.join(pAddon, 'bin', utility), 0755)




# read addon and xbmc settings
# ----------------------------

# SABnzbd-Suite
fSuiteSettings = open(pSuiteSettings, 'r')
data = fSuiteSettings.read()
fSuiteSettings.close
suiteSettings = parseString(data)
user             = getAddonSetting(suiteSettings, 'SABNZBD_USER')
pwd              = getAddonSetting(suiteSettings, 'SABNZBD_PWD')
host             = getAddonSetting(suiteSettings, 'SABNZBD_IP')
sabNzbdKeepAwake = getAddonSetting(suiteSettings, 'SABNZBD_KEEP_AWAKE')

# XBMC
fXbmcSettings = open(pXbmcSettings, 'r')
data = fXbmcSettings.read()
fXbmcSettings.close
xbmcSettings = parseString(data)
xbmcServices = xbmcSettings.getElementsByTagName('services')[0]
xbmcPort         = xbmcServices.getElementsByTagName('webserverport')[0].firstChild.data
try:
    xbmcUser     = xbmcServices.getElementsByTagName('webserverusername')[0].firstChild.data
except:
    xbmcUser = ''
try:
    xbmcPwd      = xbmcServices.getElementsByTagName('webserverpassword')[0].firstChild.data
except:
    xbmcPwd = ''



# prepare execution environment
# -----------------------------

signal.signal(signal.SIGCHLD, signal.SIG_DFL)
os.environ['PYTHONPATH'] = str(os.environ.get('PYTHONPATH')) + ':' + pPylib




# write SABnzbd settings
# ----------------------

sabNzbdConfig = ConfigObj(pSabNzbdSettings,create_empty=True)
defaultConfig = ConfigObj()
defaultConfig['misc'] = {}
defaultConfig['misc']['disable_api_key']   = '0'
defaultConfig['misc']['check_new_rel']     = '0'
defaultConfig['misc']['auto_browser']      = '0'
defaultConfig['misc']['username']          = user
defaultConfig['misc']['password']          = pwd
defaultConfig['misc']['port']              = '8081'
defaultConfig['misc']['https_port']        = '9081'
defaultConfig['misc']['https_cert']        = 'server.cert'
defaultConfig['misc']['https_key']         = 'server.key'
defaultConfig['misc']['host']              = host
defaultConfig['misc']['web_dir']           = 'Plush'
defaultConfig['misc']['web_dir2']          = 'Plush'
defaultConfig['misc']['web_color']         = 'gold'
defaultConfig['misc']['web_color2']        = 'gold'
defaultConfig['misc']['log_dir']           = 'logs'
defaultConfig['misc']['admin_dir']         = 'admin'
defaultConfig['misc']['nzb_backup_dir']    = 'backup'
defaultConfig['misc']['script_dir']        = 'scripts'

if firstLaunch:
    defaultConfig['misc']['download_dir']  = pSabNzbdIncomplete
    defaultConfig['misc']['complete_dir']  = pSabNzbdComplete
    servers = {}
    servers['localhost'] = {}
    servers['localhost']['host']           = 'localhost'
    servers['localhost']['port']           = '119'
    servers['localhost']['enable']         = '0'
    categories = {}
    categories['tv'] = {}                                 
    categories['tv']['name']               = 'tv'
    categories['tv']['script']             = 'sabToSickBeard.py'
    categories['tv']['priority']           = '-100'
    categories['movies'] = {}
    categories['movies']['name']           = 'movies'
    categories['movies']['dir']            = 'movies'
    categories['movies']['priority']       = '-100'
    categories['music'] = {}
    categories['music']['name']            = 'music'
    categories['music']['dir']             = 'music'
    categories['music']['priority']        = '-100'
    defaultConfig['servers'] = servers
    defaultConfig['categories'] = categories
    
sabNzbdConfig.merge(defaultConfig)
sabNzbdConfig.write()

# also keep the autoProcessTV config up to date
autoProcessConfig = ConfigObj(os.path.join(pSabNzbdScripts, 'autoProcessTV.cfg'), create_empty=True)
defaultConfig = ConfigObj()
defaultConfig['SickBeard'] = {}
defaultConfig['SickBeard']['host']         = 'localhost'
defaultConfig['SickBeard']['port']         = '8082'
defaultConfig['SickBeard']['username']     = user
defaultConfig['SickBeard']['password']     = pwd
autoProcessConfig.merge(defaultConfig)
autoProcessConfig.write()




# launch SABnzbd and get the API key
# ----------------------------------

logging.debug('Launching SABnzbd...')
subprocess.call(sabnzbd)
logging.debug('...done')

# SABnzbd will only complete the .ini file when we first access the web interface
if firstLaunch:
    loadWebInterface('http://' + sabNzbdHost,user,pwd)
sabNzbdConfig.reload()
sabNzbdApiKey = sabNzbdConfig['misc']['api_key']
logging.debug('SABnzbd api key: ' + sabNzbdApiKey)




# write SickBeard settings
# ------------------------

sickBeardConfig = ConfigObj(pSickBeardSettings,create_empty=True)
defaultConfig = ConfigObj()
defaultConfig['General'] = {}
defaultConfig['General']['launch_browser'] = '0'
defaultConfig['General']['version_notify'] = '0'
defaultConfig['General']['log_dir']        = 'logs'
defaultConfig['General']['web_port']       = '8082'
defaultConfig['General']['web_host']       = host
defaultConfig['General']['web_username']   = user
defaultConfig['General']['web_password']   = pwd
defaultConfig['SABnzbd'] = {}
defaultConfig['SABnzbd']['sab_username']   = user
defaultConfig['SABnzbd']['sab_password']   = pwd
defaultConfig['SABnzbd']['sab_apikey']     = sabNzbdApiKey
defaultConfig['SABnzbd']['sab_host']       = 'http://' + sabNzbdHost + '/'
defaultConfig['XBMC'] = {}
defaultConfig['XBMC']['use_xbmc']          = '1'
defaultConfig['XBMC']['xbmc_host']         = '127.0.0.1:' + xbmcPort
defaultConfig['XBMC']['xbmc_username']     = xbmcUser
defaultConfig['XBMC']['xbmc_password']     = xbmcPwd

if firstLaunch:
    defaultConfig['General']['metadata_xbmc']         = '1|1|1|1|1|1'
    defaultConfig['General']['nzb_method']            = 'sabnzbd'
    defaultConfig['General']['keep_processed_dir']    = '0'
    defaultConfig['General']['use_banner']            = '1'
    defaultConfig['General']['rename_episodes']       = '1'
    defaultConfig['General']['naming_ep_name']        = '0'
    defaultConfig['General']['naming_use_periods']    = '1'
    defaultConfig['General']['naming_sep_type']       = '1'
    defaultConfig['General']['naming_ep_type']        = '1'
    defaultConfig['General']['root_dirs']             = '0|/storage/tvshows'
    defaultConfig['SABnzbd']['sab_category']          = 'tv'
    # workaround: on first launch, sick beard will always add 
    # 'http://' and trailing '/' on its own
    defaultConfig['SABnzbd']['sab_host']              = sabNzbdHost
    defaultConfig['XBMC']['xbmc_notify_ondownload']   = '1'
    defaultConfig['XBMC']['xbmc_update_library']      = '1'
    
sickBeardConfig.merge(defaultConfig)
sickBeardConfig.write()




# launch SickBeard
# ----------------
logging.debug('Launching SickBeard...')
subprocess.call(sickBeard)
logging.debug('...done')




# write CouchPotato settings
# --------------------------

couchPotatoConfig = ConfigObj(pCouchPotatoSettings,create_empty=True)
defaultConfig = ConfigObj()
defaultConfig['global'] = {}
defaultConfig['global']['launchbrowser'] = 'False'
defaultConfig['global']['updater']       = 'False'
defaultConfig['global']['password']      = pwd
defaultConfig['global']['username']      = user
defaultConfig['global']['port']          = '8083'
defaultConfig['global']['host']          = host
defaultConfig['Sabnzbd'] = {}
defaultConfig['Sabnzbd']['username']     = user
defaultConfig['Sabnzbd']['password']     = pwd
defaultConfig['Sabnzbd']['apikey']       = sabNzbdApiKey
defaultConfig['Sabnzbd']['host']         = sabNzbdHost
defaultConfig['XBMC'] = {}
defaultConfig['XBMC']['enabled']         = 'True'
defaultConfig['XBMC']['host']            = '127.0.0.1:' + xbmcPort
defaultConfig['XBMC']['username']        = xbmcUser
defaultConfig['XBMC']['password']        = xbmcPwd

if firstLaunch:
    defaultConfig['Sabnzbd']['category']     = 'movies'
    defaultConfig['Sabnzbd']['ppdir']        = pSabNzbdCompleteMov
    defaultConfig['Renamer'] = {}
    defaultConfig['Renamer']['enabled']      = 'True'
    defaultConfig['Renamer']['download']     = pSabNzbdCompleteMov
    defaultConfig['Renamer']['destination']  = '/storage/videos'
    defaultConfig['Renamer']['separator']    = '.'
    defaultConfig['Renamer']['cleanup']      = 'True'
    
couchPotatoConfig.merge(defaultConfig)
couchPotatoConfig.write()




# launch CouchPotato
# ------------------

logging.debug('Launching CouchPotato...')
subprocess.call(couchPotato)
logging.debug('...done')




# write Headphones settings
# -------------------------

headphonesConfig = ConfigObj(pHeadphonesSettings,create_empty=True)
defaultConfig = ConfigObj()
defaultConfig['General'] = {}
defaultConfig['General']['launch_browser']   = '0'
defaultConfig['General']['http_port']        = '8084'
defaultConfig['General']['http_host']        = host
defaultConfig['General']['http_username']    = user
defaultConfig['General']['http_password']    = pwd
defaultConfig['SABnzbd'] = {}
defaultConfig['SABnzbd']['sab_apikey']       = sabNzbdApiKey
defaultConfig['SABnzbd']['sab_host']         = sabNzbdHost
defaultConfig['SABnzbd']['sab_username']     = user
defaultConfig['SABnzbd']['sab_password']     = pwd

if firstLaunch:
    defaultConfig['SABnzbd']['sab_category']     = 'music'
    defaultConfig['General']['music_dir']        = '/storage/music'
    defaultConfig['General']['destination_dir']  = '/storage/music'
    defaultConfig['General']['download_dir']     = '/storage/downloads/music' 
    defaultConfig['General']['move_files']       = '1' 
    defaultConfig['General']['rename_files']     = '1'
    
headphonesConfig.merge(defaultConfig)
headphonesConfig.write()




# launch Headphones
# -----------------

logging.debug('Launching Headphones...')
subprocess.call(headphones)
logging.debug('...done')
