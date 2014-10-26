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

PKG_NAME="mediacenter"
PKG_VERSION=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://www.openelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain $MEDIACENTER $MEDIACENTER-theme-$SKIN_DEFAULT"
PKG_PRIORITY="optional"
PKG_SECTION="virtual"
PKG_SHORTDESC="Mediacenter: Metapackage"
PKG_LONGDESC=""

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

for i in $SKINS; do
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $MEDIACENTER-theme-$i"
done

if [ "$MEDIACENTER" = "kodi" ]; then
# some python stuff needed for various addons
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET Imaging"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET simplejson"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET pycrypto"

# Kodi audio encoder addons
  if [ "$OPTICAL_DRIVE_SUPPORT" = "yes" ]; then
    for audioencoder in $KODI_AUDIOENCODER_ADDONS; do
      PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET kodi-audioencoder-$audioencoder"
    done
  fi

# various PVR clients
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET kodi-pvr-addons"
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET kodi-addon-xvdr"

# other packages
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET OpenELEC-settings"
fi
