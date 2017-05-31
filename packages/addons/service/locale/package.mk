################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2017-present Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="locale"
PKG_REV="101"
PKG_ARCH="any"
PKG_DEPENDS_TARGET="toolchain glibc"
PKG_SECTION="service"
PKG_SHORTDESC="Locale: allows users to set a custom locale to override the POSIX default"
PKG_LONGDESC="Locale ($PKG_REV) allows users to set a custom locale in the OS to override the POSIX default"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="Locale"
PKG_ADDON_TYPE="xbmc.service"

make_target() {
  : # nothing to do
}

makeinstall_target() {
  : # nothing to do
}

addon() {
  mkdir -p "$ADDON_BUILD/$PKG_ADDON_ID/i18n"
  cp -PR "$(get_build_dir glibc)/localedata/charmaps" \
         "$(get_build_dir glibc)/localedata/locales" \
         "$ADDON_BUILD/$PKG_ADDON_ID/i18n"

  mkdir -p "$ADDON_BUILD/$PKG_ADDON_ID/locpath"

  cp -PR $PKG_DIR/resources $ADDON_BUILD/$PKG_ADDON_ID

  locales=""
  for p in "$ADDON_BUILD/$PKG_ADDON_ID/i18n/locales"/*; do
    l="$(basename $p)"
    if [ "$l" = "POSIX" ]; then
      continue
    fi
    locales="$locales|$l"
  done
  locales="${locales:1}"

  sed -e "s/@LOCALES@/$locales/" \
      -i $ADDON_BUILD/$PKG_ADDON_ID/resources/settings.xml
}
