import xbmc

from ls_addon import log as log
from ls_addon import notification as notification
from ls_librespot import Librespot as Librespot


class Monitor(xbmc.Monitor):

    def onSettingsChanged(self):
        self.is_changed = True

    def run(self):
        log('monitor started')
        is_aborted = False
        is_dead = False
        while not (is_aborted or is_dead):
            self.is_changed = False
            librespot = Librespot()
            with librespot:
                while True:
                    is_aborted = self.waitForAbort(1)
                    if is_aborted:
                        log('monitor aborted')
                        librespot.is_aborted = True
                        break
                    is_dead = librespot.is_dead
                    if is_dead:
                        log('librespot died')
                        notification('Too many errors')
                        break
                    if self.is_changed:
                        log('settings changed')
                        break
        log('monitor stopped')
