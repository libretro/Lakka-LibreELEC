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

PKG_NAME="mediacenter"
PKG_VERSION=""
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://libreelec.tv"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain $MEDIACENTER"
PKG_SECTION="virtual"
PKG_SHORTDESC="Mediacenter: Metapackage"
PKG_LONGDESC="Mediacenter: Metapackage"

if [ "$MEDIACENTER" = "kodi" ]; then
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $MEDIACENTER-theme-$SKIN_DEFAULT"

  for i in $SKINS; do
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET $MEDIACENTER-theme-$i"
  done

# some python stuff needed for various addons
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET Pillow \
                                          simplejson \
                                          pycryptodome"
# other packages
  PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET LibreELEC-settings \
                                          xmlstarlet"

  if [ "$JOYSTICK_SUPPORT" = "yes" ]; then
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET peripheral.joystick"
  fi

  get_graphicdrivers
  if listcontains "$GRAPHIC_DRIVERS" "(i915|i965)"; then
    PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET intel-vaapi-driver"
  fi

fi
