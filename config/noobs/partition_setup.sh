#!/bin/sh -x
################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

MOUNTPOINT="/tmp/OpenELEC-System"

md5sumCheck() {
  ( cd $MOUNTPOINT
    echo "checking MD5: $1"
    md5sum -c $1.md5
    if [ "$?" = "1" ]; then
      echo "######################################################"
      echo "#                                                    #"
      echo "# OpenELEC failed md5 check - Installation will quit #"
      echo "#                                                    #"
      echo "#    Your original download was probably corrupt.    #"
      echo "#  Please visit www.openelec.tv and get another copy #"
      echo "#                                                    #"
      echo "######################################################"
      exit 1
    fi
    rm -rf $1.md5
  )
}

if [ -z $part1 -o -z $part2 -o -z $id1 -o -z $id2 ]; then
  echo "error: part1, part2, id1 or id2 not specified"
  echo "actual values:"
  echo "part1:" $part1
  echo "part2:" $part2
  echo "id1  :" $id1
  echo "id2  :" $id2
  exit 1
fi

# create mountpoint
  mkdir -p $MOUNTPOINT

# mount needed partition
  mount $part1 $MOUNTPOINT

# check md5sum
  md5sumCheck kernel.img
  md5sumCheck SYSTEM

# create bootloader configuration
  echo "creating bootloader configuration..."
  echo "boot=$id1 disk=$id2 quiet" > $MOUNTPOINT/cmdline.txt

# cleanup mountpoint
  umount $MOUNTPOINT
  rmdir $MOUNTPOINT
