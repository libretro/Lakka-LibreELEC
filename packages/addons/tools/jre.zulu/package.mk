# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Peter Vicman (peter.vicman@gmail.com)

PKG_NAME="jre.zulu"
PKG_VERSION="1.0"
PKG_REV="100"
PKG_LICENSE="GPL2"
PKG_DEPENDS_TARGET="jdk-${TARGET_ARCH}-zulu jre-libbluray libXext chrome-libXtst chrome-libXi chrome-libXrender jre-libXinerama"
PKG_SECTION="tools"
PKG_SHORTDESC="Java Runtime Environment 8 for Blu-ray Disc Java menus from Azul Systems."
PKG_LONGDESC="$PKG_SHORTDESC"
PKG_TOOLCHAIN="manual"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="JRE for BD-J menus"
PKG_ADDON_TYPE="xbmc.python.script"

# find $1.so.[0-9]* in $2 and copy it to dest
_pkg_copy_lib() {
  find "$2" -regextype sed -regex ".*/$1\.so\.[0-9]*" \
    -exec cp {} "$ADDON_BUILD/$PKG_ADDON_ID/lib" \;
}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib

  cp -a $(get_build_dir jdk-${TARGET_ARCH}-zulu)/jre \
        $(get_build_dir jre-libbluray)/.$TARGET_NAME/.libs/*.jar \
        ${PKG_DIR}/profile.d \
    $ADDON_BUILD/$PKG_ADDON_ID

  # copy required libraries for JRE
  _pkg_copy_lib libXtst $(get_build_dir chrome-libXtst)/.$TARGET_NAME/src/.libs
  _pkg_copy_lib libXi $(get_build_dir chrome-libXi)/.$TARGET_NAME/src/.libs
  _pkg_copy_lib libXrender $(get_build_dir chrome-libXrender)/.$TARGET_NAME/src/.libs
  _pkg_copy_lib libXinerama $(get_build_dir jre-libXinerama)/.$TARGET_NAME/src/.libs

  if [ "$TARGET_ARCH" = "arm" ]; then
    _pkg_copy_lib libX11 $(get_build_dir libX11)/.$TARGET_NAME/src/.libs
    _pkg_copy_lib libXext $(get_build_dir libXext)/.$TARGET_NAME/src/.libs
  fi
}
