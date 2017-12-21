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

# with 1.0.0 repeat delay is broken. test on upgrade

PKG_NAME="v4l-utils"
PKG_VERSION="1.12.3"
PKG_SHA256="5a47dd6f0e7dfe902d94605c01d385a4a4e87583ff5856d6f181900ea81cf46e"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="http://linuxtv.org/"
PKG_URL="http://linuxtv.org/downloads/v4l-utils/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="system"
PKG_SHORTDESC="v4l-utils: Linux V4L2 and DVB API utilities and v4l libraries (libv4l)."
PKG_LONGDESC="Linux V4L2 and DVB API utilities and v4l libraries (libv4l)."

PKG_CONFIGURE_OPTS_TARGET="--without-jpeg"

pre_configure_target() {
  # cec-ctl fails to build in subdirs
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
}

make_target() {
  make -C utils/keytable CFLAGS="$TARGET_CFLAGS"
  make -C utils/ir-ctl CFLAGS="$TARGET_CFLAGS"
  if [ "$CEC_FRAMEWORK_SUPPORT" = "yes" ]; then
    make -C utils/cec-ctl CFLAGS="$TARGET_CFLAGS"
  fi
}

makeinstall_target() {
  make install DESTDIR=$INSTALL PREFIX=/usr -C utils/keytable
  make install DESTDIR=$INSTALL PREFIX=/usr -C utils/ir-ctl
  if [ "$CEC_FRAMEWORK_SUPPORT" = "yes" ]; then
    make install DESTDIR=$INSTALL PREFIX=/usr -C utils/cec-ctl
  fi
}

create_multi_keymap() {
  local f name protocols
  name="$1"
  protocols="$2"
  shift 2
  (
    echo "# table $name, type: $protocols"
    for f in "$@" ; do
      echo "# $f"
      grep -v "^#" $INSTALL/usr/lib/udev/rc_keymaps/$f
    done
  ) > $INSTALL/usr/lib/udev/rc_keymaps/$name
}

post_makeinstall_target() {
  local default_multi_maps f keymap

  rm -rf $INSTALL/etc/rc_keymaps
    ln -sf /storage/.config/rc_keymaps $INSTALL/etc/rc_keymaps

  mkdir -p $INSTALL/usr/config
    cp -PR $PKG_DIR/config/* $INSTALL/usr/config

  rm -rf $INSTALL/usr/lib/udev/rules.d
    mkdir -p $INSTALL/usr/lib/udev/rules.d
    cp -PR $PKG_DIR/udev.d/*.rules $INSTALL/usr/lib/udev/rules.d

  # install additional keymaps without overwriting upstream maps
  (
    set -C
    for f in $PKG_DIR/keymaps/* ; do
      if [ -e $f ] ; then
        keymap=$(basename $f)
        cat $f > $INSTALL/usr/lib/udev/rc_keymaps/$keymap
      fi
    done
  )

  # create multi keymap to support several remotes OOTB

  default_multi_maps="rc6_mce xbox_360 zotac_ad10 hp_mce xbox_one cubox_i"

  create_multi_keymap libreelec_multi "RC6 NEC" $default_multi_maps

  # use multi-keymap instead of default one
  sed -i '/^\*\s*rc-rc6-mce\s*rc6_mce/d' $INSTALL/etc/rc_maps.cfg
  cat << EOF >> $INSTALL/etc/rc_maps.cfg
#
# Custom LibreELEC configuration starts here
#
# use combined multi-table on MCE receivers
# *	rc-rc6-mce	rc6_mce
*	rc-rc6-mce	libreelec_multi
# additional non-upstreamed keymaps
*	rc-odroid	odroid
*	rc-wetek-hub	wetek_hub
EOF
}
