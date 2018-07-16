# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)

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
