# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

# with 1.0.0 repeat delay is broken. test on upgrade

PKG_NAME="v4l-utils"
PKG_VERSION="1.14.2"
PKG_SHA256="e6b962c4b1253cf852c31da13fd6b5bb7cbe5aa9e182881aec55123bae680692"
PKG_LICENSE="GPL"
PKG_SITE="http://linuxtv.org/"
PKG_URL="http://linuxtv.org/downloads/v4l-utils/$PKG_NAME-$PKG_VERSION.tar.bz2"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Linux V4L2 and DVB API utilities and v4l libraries (libv4l)."

PKG_CONFIGURE_OPTS_TARGET="--without-jpeg \
	--enable-static \
	--disable-shared"

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
  make -C lib CFLAGS="$TARGET_CFLAGS"
  make -C utils/dvb CFLAGS="$TARGET_CFLAGS"
  make -C utils/v4l2-ctl CFLAGS="$TARGET_CFLAGS"
}

makeinstall_target() {
  make install DESTDIR=$INSTALL PREFIX=/usr -C utils/keytable
  make install DESTDIR=$INSTALL PREFIX=/usr -C utils/ir-ctl
  if [ "$CEC_FRAMEWORK_SUPPORT" = "yes" ]; then
    make install DESTDIR=$INSTALL PREFIX=/usr -C utils/cec-ctl
  fi
  make install DESTDIR=$INSTALL PREFIX=/usr -C utils/dvb
  make install DESTDIR=$INSTALL PREFIX=/usr -C utils/v4l2-ctl
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
  local f keymap

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
  if [ -n "$IR_REMOTE_PROTOCOLS" -a -n "$IR_REMOTE_KEYMAPS" ]; then
    create_multi_keymap libreelec_multi "$IR_REMOTE_PROTOCOLS" $IR_REMOTE_KEYMAPS

    # use multi-keymap instead of default one
    sed -i '/^\*\s*rc-rc6-mce\s*rc6_mce/d' $INSTALL/etc/rc_maps.cfg

    cat << EOF >> $INSTALL/etc/rc_maps.cfg
#
# Custom LibreELEC configuration starts here
#
# use combined multi-table on MCE receivers
# *		rc-rc6-mce	rc6_mce
*		rc-rc6-mce	libreelec_multi
# table for Xbox DVD Playback Kit
*		rc-xbox-dvd	xbox_dvd
# multi-table for amlogic devices
meson-ir	*		libreelec_multi
EOF

  fi
}
