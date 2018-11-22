# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="alsa-utils"
PKG_VERSION="1.1.7"
PKG_SHA256="1db27fb54ab7fdeb54b00d68b8a174808ffea198cfbd67e3c959482194e1540a"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="ftp://ftp.alsa-project.org/pub/utils/alsa-utils-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain alsa-lib ncurses"
PKG_LONGDESC="This package includes the utilities for ALSA, like alsamixer, aplay, arecord, alsactl, iecset and speaker-test."

PKG_CONFIGURE_OPTS_TARGET="--disable-alsaconf \
                           --disable-alsaloop \
                           --enable-alsatest \
                           --disable-bat \
                           --disable-dependency-tracking \
                           --disable-nls \
                           --disable-rst2man \
                           --disable-xmlto"

post_makeinstall_target() {
  rm -rf $INSTALL/lib $INSTALL/var
  rm -rf $INSTALL/usr/share/alsa/speaker-test
  rm -rf $INSTALL/usr/share/sounds
  rm -rf $INSTALL/usr/lib/systemd/system

# remove default udev rule to restore mixer configs, we install our own.
# so we avoid resetting our soundconfig
  rm -rf $INSTALL/usr/lib/udev/rules.d/90-alsa-restore.rules

  for i in aconnect alsamixer alsaucm amidi aplaymidi arecord arecordmidi aseqdump aseqnet iecset; do
    rm -rf $INSTALL/usr/bin/$i
  done

  mkdir -p $INSTALL/usr/lib/udev
    cp $PKG_DIR/scripts/soundconfig $INSTALL/usr/lib/udev
}
