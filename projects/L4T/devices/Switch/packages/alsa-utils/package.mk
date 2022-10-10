# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="alsa-utils"
PKG_VERSION="1.2.4"
PKG_SHA256="98ffc2d599de0577d423a48fa5f20a992ca0b82d812ed1f2e58ade49ac6da426"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="ftp://ftp.alsa-project.org/pub/utils/alsa-utils-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain alsa-lib ncurses systemd"
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
  rm -rf ${INSTALL}/lib ${INSTALL}/var
  rm -rf ${INSTALL}/usr/share/alsa/speaker-test
  rm -rf ${INSTALL}/usr/share/sounds
  rm -rf ${INSTALL}/usr/lib/systemd/system

# remove default udev rule to restore mixer configs, we install our own.
# so we avoid resetting our soundconfig
  rm -rf ${INSTALL}/usr/lib/udev/rules.d/90-alsa-restore.rules

  if [ "${DISTRO}" != "Lakka" ]; then # keep the utils for Lakka
    mkdir -p ${INSTALL}/.noinstall
      for i in aconnect alsamixer amidi aplaymidi arecord arecordmidi aseqdump aseqnet iecset; do
        mv ${INSTALL}/usr/bin/${i} ${INSTALL}/.noinstall
      done
  fi

  mkdir -p ${INSTALL}/usr/lib/udev
    cp ${PKG_DIR}/scripts/soundconfig ${INSTALL}/usr/lib/udev
}
