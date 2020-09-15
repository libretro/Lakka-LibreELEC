import os
import socket
import xbmc
import xbmcaddon
import xbmcgui


DEFAULTS = dict(
    autoplay='true',
    bitrate='320',
    device='librespot',
    discovery='true',
    name='Librespot@{}',
    password='',
    rtp_dest='127.0.0.1',
    rtp_port='24642',
    username='',
)

ADDON = xbmcaddon.Addon()
ADDON_HOME = xbmc.translatePath(ADDON.getAddonInfo('profile'))
ADDON_ICON = ADDON.getAddonInfo('icon')
ADDON_NAME = ADDON.getAddonInfo('name')
ADDON_PATH = ADDON.getAddonInfo('path')
ADDON_ENVT = dict(
    LD_LIBRARY_PATH=os.path.join(ADDON_PATH, 'lib'),
    PATH=os.path.join(ADDON_PATH, 'bin'))
DIALOG = xbmcgui.Dialog()


def get_settings():
    if not os.path.exists(ADDON_HOME):
        os.makedirs(ADDON_HOME)
    settings = dict()
    for id in DEFAULTS.keys():
        value = ADDON.getSetting(id)
        settings[id] = DEFAULTS[id] if value == '' else value
    settings['name'] = settings['name'].format(socket.gethostname())
    return settings


def log(message):
    xbmc.log('{}: {}'.format(ADDON_NAME, message), xbmc.LOGNOTICE)


def notification(message):
    DIALOG.notification(ADDON_NAME, message, ADDON_ICON)
