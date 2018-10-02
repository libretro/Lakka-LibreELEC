# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="dvb-apps"
PKG_VERSION="3d43b280298c"
PKG_SHA256="70c1d293ea3ddbcb970e01c8a51487ee97a4dcf33a73c0236c7d57757c7f6fb0"
PKG_LICENSE="GPL"
PKG_SITE="https://www.linuxtv.org/wiki/index.php/LinuxTV_dvb-apps"
PKG_URL="http://linuxtv.org/hg/dvb-apps/archive/${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Applications for initial setup, testing and operation of an DVB device supporting the DVB-S, DVB-C, DVB-T, and ATSC."

pre_make_target() {
  export PERL_USE_UNSAFE_INC=1
}

makeinstall_target() {
 :
}
