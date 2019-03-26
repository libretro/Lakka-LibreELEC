# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'resources', 'lib'))

from ls_monitor import Monitor as Monitor


if __name__ == '__main__':
    Monitor().waitForAbort()
