#!/bin/sh

################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

. /etc/profile

run_scripts()
{
    list_scripts $1
    for script in $SCRIPTS ; do
        progress "running sleep script $script ($1)..."
        sh /lib/systemd/system-sleep.serial/$script $1
    done
}

list_scripts()
{
    case $1 in
        pre)
            SCRIPTS=$(ls /lib/systemd/system-sleep.serial/ | sort)
        ;;
        post)
            SCRIPTS=$(ls /lib/systemd/system-sleep.serial/ | sort -r)
        ;;
    esac
}

run_scripts $1

exit 0
