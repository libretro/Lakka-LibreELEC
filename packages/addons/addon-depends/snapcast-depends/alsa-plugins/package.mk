# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="alsa-plugins"
PKG_VERSION="1.2.6"
PKG_SHA256="068818a4b55d8c029daa00015d853d45113f56b224b7c64e1e117988c825b2a0"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL="ftp://ftp.alsa-project.org/pub/plugins/${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain alsa-lib"
PKG_LONGDESC="Alsa plugins."

if [ "${PULSEAUDIO_SUPPORT}" = yes ]; then
  PKG_DEPENDS_TARGET+=" pulseaudio"
  SUBDIR_PULSEAUDIO="pulse"
fi

PKG_CONFIGURE_OPTS_TARGET="--with-plugindir=/usr/lib/alsa"
PKG_MAKE_OPTS_TARGET="SUBDIRS=${SUBDIR_PULSEAUDIO}"
PKG_MAKEINSTALL_OPTS_TARGET="SUBDIRS=${SUBDIR_PULSEAUDIO}"
