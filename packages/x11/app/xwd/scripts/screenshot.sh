#!/bin/bash

# Screenshot script
#
# Author Tómas Edwardsson <tommi@tommi.org>

[ -f $HOME/noscreenshot ] && exit


WHERE="$HOME/screenshots/`date +%Y/%m/%d`"
FILE="$WHERE`date +/screenshot-%H%M`"

mkdir -p $WHERE
/usr/bin/xwd -display :0.0 -root -out $FILE.xwd

#/usr/bin/convert  $FILE.xwd $FILE.png
#/bin/rm -f $FILE.xwd
