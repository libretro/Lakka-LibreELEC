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

PKG_NAME="alsa"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.alsa-project.org/"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain alsa-lib alsa-utils"
PKG_PRIORITY="optional"
PKG_SECTION="virtual"
PKG_SHORTDESC="alsa: Matapackage to install all alsa components"
PKG_LONGDESC="ALSA (Advanced Linux Sound Architecture) is the next generation Linux Sound API. It provides much finer (->better) access to the sound hardware, has a unbeatable mixer API and supports stuff like multi channel hardware, digital outs and ins, uninterleaved sound data access, and an oss emulation layer (for the old applications). It is the prefered API for professional sound apps under Linux."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"
