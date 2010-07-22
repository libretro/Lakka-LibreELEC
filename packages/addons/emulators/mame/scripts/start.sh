#!/bin/sh

################################################################################
#      Copyright (C) 2009-2010 OpenELEC.tv
#      http://www.openelec.tv
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

# make directory structure for mame
  mkdir -p $HOME/emulators/mame/roms
  mkdir -p $HOME/emulators/mame/samples
  mkdir -p $HOME/emulators/mame/artwork
  mkdir -p $HOME/emulators/mame/ctrlr
  mkdir -p $HOME/emulators/mame/ini
  mkdir -p $HOME/emulators/mame/fonts
  mkdir -p $HOME/emulators/mame/cheat
  mkdir -p $HOME/emulators/mame/crosshair

mkdir -p image
  mount -o loop mame.img image

ln -sf image/* .
./bin/mame $@

umount image

