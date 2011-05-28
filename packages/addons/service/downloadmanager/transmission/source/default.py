################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2011 Stephan Raue (stephan@openelec.tv)
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
#  the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

import xbmc, time, os, subprocess

dir = os.path.realpath(os.path.dirname(__file__))
script = 'start.sh'

launcher = os.path.join(dir, script)
app = '/storage/.xbmc/addons/service.downloadmanager.transmission/bin/transmission-daemon'

os.chmod(launcher, 0755)
os.chmod(app, 0755)

args = [launcher, str(os.getpid()), app]

p = subprocess.Popen(args)
print p.pid
p.wait()
os.exit(1)
