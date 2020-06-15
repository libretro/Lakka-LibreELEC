import os
import sys

sys.path.append(os.path.join(os.path.dirname(__file__), 'resources', 'lib'))

from ls_monitor import Monitor as Monitor

Monitor().run()
